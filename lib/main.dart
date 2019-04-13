import 'package:flutter/material.dart';
import './pages/DailyPostPage.dart';
import './pages/CalendarPage.dart';
import './pages/SettingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开源日报',
      color: Color(0xff4384f7),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorBrightness: Brightness.light,
        brightness: Brightness.light,
        backgroundColor: Color(0xfff2f3f5),
      ),
      home: HomePage(),
    );
  }
}

//首页，定义导航栏等基本框架。
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        elevation: 0,
        backgroundColor: Color(0xfff2f3f5),
        title: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorWeight: 1.0,
            labelColor: Color(0xff4384f7),
            unselectedLabelColor: Color(0xff666666),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.calendar_view_day)),
              Tab(icon: Icon(Icons.today)),
              Tab(icon: Icon(Icons.settings)),
            ],
            controller: _tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CalendarPage(),
          DailyPostPage(),
          SettingPage()
        ],
      ),
    );
  }
}
