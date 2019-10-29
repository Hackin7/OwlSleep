import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  String _currentMonth = '';
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.white,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  
  @override
  Widget build(BuildContext context) {

    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.white,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(color: Colors.white,),
	  weekdayTextStyle: TextStyle(color: Colors.white,),
      thisMonthDayBorderColor: Colors.white,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 470.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: CircleBorder(
        side: BorderSide(color: Colors.white)
      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      showHeader: true,
      showHeaderButton: false,
      headerTextStyle: TextStyle(fontSize: 20.0,color:Colors.white),
	  headerTitleTouchable: true,
	  
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
	
	
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body:Container(
      decoration: new BoxDecoration(color: Color(0xff7c8aa7)),
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
			Image(image: AssetImage("assets/Owl.png"),height: 300, width:300),
			_calendarCarouselNoHeader,

          ],
        ),
      ),
	  
	  //https://medium.com/coding-with-flutter/flutter-case-study-multiple-navigators-with-bottomnavigationbar-90eb6caa6dbf
	  
	  bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.shifting ,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('Sleep Cycle', style:TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('Timetable', style:TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('App Lock', style:TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm,color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text('Game & Shop', style:TextStyle(color: Colors.black))
          )
        ],
	  ),
    );
  }
}
