import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wall_e/Bloc/wallpaperBloc.dart';
import 'package:wall_e/Bloc/wallpaperEvent.dart';
import 'package:wall_e/Screens/CategoryList.dart' as categoryScreen;
import 'package:wall_e/Screens/EditorChoice.dart';
import 'package:wall_e/Screens/Search.dart';
import 'package:wall_e/Screens/Setting.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage(this.title);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WallpaperBloc _wallpaperBloc;
  int _selectedIndex = 0;
  PageController controller = PageController();
  List<GButton> tabs = new List();
  @override
  void initState() {
    super.initState();
    var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
    double gap = 10;

    tabs.add(GButton(
      gap: gap,
      iconActiveColor: Colors.white,
      iconColor: Colors.white,
      textColor: Colors.white,
      backgroundColor: Colors.grey[900],
      iconSize: 24,
      padding: padding,
      icon: Icons.verified_user,
      text: "Parth's Choice",
    ));

    tabs.add(GButton(
      gap: gap,
      iconActiveColor: Colors.white,
      iconColor: Colors.white,
      textColor: Colors.white,
      backgroundColor: Colors.grey[900],
      iconSize: 24,
      padding: padding,
      icon: Icons.category,
      text: 'Category',
    ));
  }

  @override
  Widget build(BuildContext context) {
    _wallpaperBloc = BlocProvider.of<WallpaperBloc>(context);
    _wallpaperBloc.add(GetAllWallpaper());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'ProductSans'),
        ),
        centerTitle: true,
        actions: <Widget>[

        ],
      ),
      body: PageView.builder(
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return getScreen(index);
        },
        itemCount: tabs.length,
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: -10,
                        blurRadius: 60,
                        color: Colors.black.withOpacity(.20),
                        offset: Offset(0, 15))
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: GNav(

                    tabs: tabs,
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                      controller.jumpToPage(index);
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900]
                ,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Search()));
                },
                elevation: 3.0,
              ),
            ),


          ],
        ),
      ),
    );
  }
}

getScreen(int selectedIndex) {
  if (selectedIndex == 0) {
    return EditorChoice();
  } else if (selectedIndex == 1) {
    return categoryScreen.CategoryList();
  }
}
