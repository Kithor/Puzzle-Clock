import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'alarm.dart';
import 'edit.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel _list;
  var _selectedItem;

  @override
  void initState() {
    super.initState();
    _list = ListModel(
      listKey: _listKey,
      initialItems: Alarm.alarmList,
      removedItemBuilder: _buildRemovedItem,
    );
    if(Alarm.audioPlayer != null){
      Alarm.stop();
    }
    _cancelNotification();
    _startClock();

    /* Initialize Local Notifications */
    var androidSettings = new AndroidInitializationSettings('ic_launcher');
    var iOSSettings = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(androidSettings, iOSSettings);
    localNotifications.initialize(initializationSettings);
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      var item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert(Alarm alarm) {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, alarm);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      Alarm.alarmList.removeAt(Alarm.alarmList.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  // Start the clock to check every minute for an alarm
  void _startClock(){
    if(Alarm.clockStarted == false){
      Alarm.loadAudio();
      new Timer.periodic(new Duration(milliseconds: 5), (syncTimer) { //Sync Timer (syncTimer)
        if(DateTime.now().second == 00){
          Timer.periodic(const Duration(minutes:1), (periodTimer) { //Periodic Timer (_)
            print(">>${DateTime.now().minute}");
            Alarm.alarmList.forEach((element) => _checkAlarm(element));
          });
          syncTimer.cancel();
        }
      });
      Alarm.clockStarted = true;
    }
  }

  //A function to check the list for an alarm every tick
  void _checkAlarm(alarm) async{
    print('${alarm.time} // ${DateTime.now()}');
    if(alarm.time.hour == DateTime.now().hour && alarm.isSet == true){
      if(alarm.time.minute <= DateTime.now().minute){
        alarm.isSet = false;
        _showNotification(alarm);
        alarm.start(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('On Time'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              //onPressed: _insert,
              onPressed: (){
                dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditAlarm()),
                );
              },
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body:
        new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    )
  );
 }

  /* Notification functions */
  Future _showNotification(alarm) async {
    var androidSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidSpecifics, iOSSpecifics);
    await localNotifications.show(
        0, 'Alarm', '${alarm.time.hour}:${alarm.time.minute}', platformChannelSpecifics, payload: 'item x');
  }

  Future _cancelNotification() async {
    await localNotifications.cancel(0);
  }
}

/// Keeps a Dart List in sync with an AnimatedList.
///
/// The [insert] and [removeAt] methods apply to both the internal list and the
/// animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that mutate the
/// list must make the same changes to the animated list in terms of
/// [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {                                //Card Item takes in an object with the required variables. Insert alarm data with it.
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 128.0,
            child: Card(
              color: Colors.lightBlue,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
                          child: Text(item.name, style: textStyle)
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                          child: Text(DateFormat('jm').format(item.time), 
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.alarm,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}

FlutterLocalNotificationsPlugin localNotifications;

main() async{
  localNotifications = new FlutterLocalNotificationsPlugin();
  runApp(
    new MaterialApp(
      home: App(),
    )
  );
}