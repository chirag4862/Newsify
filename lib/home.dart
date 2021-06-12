import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsify/backend/rss_to_json.dart';
import 'package:newsify/screens/home/homepage.dart';
import 'package:newsify/screens/search/search.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Map<String, List> newsData = Map<String, List>();
  bool isLoading = true;
  getData() async {
    Future.wait([
      rssToJson('topnews'),
      rssToJson('india'),
      rssToJson('world-news'),
      rssToJson('business'),
      rssToJson('sports'),
      rssToJson('cricket'),
      rssToJson('education'),
      rssToJson('entertainment'),
      rssToJson('lifestyle'),
      rssToJson('health-fitness'),
      rssToJson('books'),
      rssToJson('trending'),
    ]).then((value) {
      value[0] = [];
      value.forEach((element) {
        value[0].addAll([...element ?? []]);
      });
      value[0].shuffle();
      newsData['topnews'] = value[0].sublist(0, 10);
      newsData['india'] = value[1];
      newsData['world'] = value[2];
      newsData['business'] = value[3];
      newsData['sports'] = value[4];
      newsData['cricket'] = value[5];
      newsData['education'] = value[6];
      newsData['entertainment'] = value[7];
      newsData['lifestyle'] = value[8];
      newsData['health-fitness'] = value[9];
      newsData['books'] = value[10];
      newsData['its-viral'] = value[11];
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Builder(
              builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer())),
        ),
        titleSpacing: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            DrawerHeader(
                child: Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/logo.png",
                    )),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                )),
            SizedBox(height: 20),
            Text('Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 45),
            Text('Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 45),
            Text('About',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 45),
            Text('Log Out',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 45),
            Material(
              borderRadius: BorderRadius.circular(500),
              child: InkWell(
                  borderRadius: BorderRadius.circular(500),
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  )),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Center(
                  child: Text('v1.0.1',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                ),
              ),
            ))
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : <Widget>[
              HomePage(
                newsData: newsData,
              ),
              Search(),
              Container(
                color: Colors.indigo,
              ),
              Container(
                color: Colors.green,
              ),
            ][currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.1,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasNotch: true, //new
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Colors.deepPurple,
              ),
              title: Text("Search")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.bookmark,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.bookmark,
                color: Colors.indigo,
              ),
              title: Text("Bookmark")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: Colors.green,
              ),
              title: Text("User"))
        ],
      ),
    );
  }
}
