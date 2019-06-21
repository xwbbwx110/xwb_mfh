import 'package:flutter/material.dart';
import 'package:xwb_mfh/ui/home_page.dart';
import 'dart:async';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                color: const Color(0xFAFAFA),
                child: PageView.builder(

                  onPageChanged:_pageChange,
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context,int index){



                    if(index==0){
                      return MainPage(lableId: "one");
                    }else if(index==1){
                      return MainPage(lableId: "one");
                    }else if(index==2){
                      return MainPage(lableId: "one");
                    }


                    return Text("xxx");

                  },
                  itemCount: 5,
                )
            ),
          ),
          Container(
            child: BottomNavigationBar(
              fixedColor: Colors.black,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon:  Image.asset ('images/v8_ic_tab_homepage_normal.png'
                    ),
                    title:  Text("首页"),
                    activeIcon:  Image.asset ('images/v8_ic_tab_homepage_selected.png')),

                BottomNavigationBarItem(
                    icon:  Image.asset ('images/v8_ic_tab_destination_normal.png' ),
                    title:  Text("成都"),
                    activeIcon:  Image.asset ('images/v8_ic_tab_destination_selected.png')),

                BottomNavigationBarItem(
                    icon:  Image.asset ('images/v8_ic_tab_hotel_normal.png' ),
                    title:  Text("钉酒店"),
                    activeIcon:  Image.asset ('images/v8_ic_tab_hotel_selected.png')),
                BottomNavigationBarItem(
                    icon:  Image.asset ('images/v8_ic_tab_default_mall.png' ),
                    title:  Text("去旅行"),
                    activeIcon:  Image.asset ('images/v8_ic_tab_focused_mall.png')),

                BottomNavigationBarItem(
                    icon:  Image.asset ('images/v8_ic_tab_mine_normal.png' ),
                    title:  Text("我的"),
                    activeIcon:  Image.asset ('images/v8_ic_tab_mine_selected.png')),
              ],
              currentIndex: _currentPageIndex,
              onTap: (int index){
                _pageController.animateToPage(index, duration: new Duration(seconds: 1),curve:new ElasticOutCurve(1.0));
                _pageChange(index);
              },
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x4DFFD700),
                      offset: Offset(0.0, -0.0) ,
                      blurRadius: 20.0,
                      spreadRadius: 2.0
                  )
                ]
            ),
          )

        ],
      )
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.light
      ),
      home: new HomePage(),
    );
  }
}


void main() {

  final StreamController ctrl = StreamController();

  ctrl.stream.listen((data){
    print(data);
    print(data);
  });


  ctrl.sink.add("my name");
  ctrl.sink.add(1234);

  ctrl.close();



  runApp(new  MyApp());
}