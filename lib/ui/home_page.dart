import 'package:flutter/material.dart';
import 'package:flukit/flukit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xwb_mfh/widget/widgets.dart';
import 'package:xwb_mfh/models/modelData.dart';
import 'package:xwb_mfh/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final List<String> _paths = <String>[
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559300821961&di=1bdcfa6a304602b3b66bd8d198097bc2&imgtype=0&src=http%3A%2F%2F00.imgmini.eastday.com%2Fmobile%2F20171128%2F20171128112137_e5d2f098562da2e3b9ca6d84f6e15e91_2.jpeg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559300821959&di=5c7cf85a1cab7b08b4948c1031241e73&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201509%2F15%2F20150915182739_ewWsA.jpeg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559300930197&di=a25026b7c78bfb3e00897d0540892d90&imgtype=0&src=http%3A%2F%2Fsource.upupoo.com%2Ftheme%2F2000067543%2Fpreview.jpg",
  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559301069218&di=194cde2f00a7b02cece0ad3ada6ef71c&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201601%2F17%2F20160117131728_kFuG4.thumb.700_0.jpeg"
];

final List<HomeTabModel> _homeTab = <HomeTabModel>[
  HomeTabModel(imgUrl: "home_tab_strategy", title: "攻略"),
  HomeTabModel(imgUrl: "home_tab_hotel", title: "订酒店"),
  HomeTabModel(imgUrl: "home_tab_ticket", title: "机票火车票"),
  HomeTabModel(imgUrl: "home_tab_travel", title: "去旅游"),
  HomeTabModel(imgUrl: "home_tab_travel_notes", title: "游记"),
];

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(18.0)),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 14.0)),
    );
  }
}

class ItemContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ItemContentState();
  }
}

class ItemContentState extends State<ItemContent> {
  var path2 =
      "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3538052241,3397777967&fm=11&gp=0.jpg";

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: path2,
          height: getHeight(context),
          fit: BoxFit.cover,
//                placeholder: (content, url) => ProgressView(),
          errorWidget: (content, url, error) => Icon(Icons.error),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: new BorderRadius.circular(14.0)),
            padding: EdgeInsets.only(left: 6.0, right: 6.0),
            margin: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Image.asset('images/baseline_location_on_white.png'),
                Text("成都",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  //每页的标签ID
  final String lableId;

  const MainPage({Key key, this.lableId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Row widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  //lunbo
  Widget buildBunner(BuildContext content, List<String> imgPaths) {
    if (imgPaths.isEmpty) {
      return null;
    }
    return AspectRatio(
      aspectRatio: 18.5 / 9,
      child: Swiper(
          indicator: NumberSwiperIndicator(),
          interval: const Duration(seconds: 3),
          circular: true,
          indicatorAlignment: AlignmentDirectional.bottomStart,
          children: imgPaths.map((path) {
            return new InkWell(
              onTap: () {},
              child: CachedNetworkImage(
                imageUrl: path,
                fit: BoxFit.cover,
                placeholder: (content, url) => ProgressView(),
                errorWidget: (content, url, error) => Icon(Icons.error),
              ),
            );
          }).toList()),
    );
  }

  Widget buildTextField() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      alignment: Alignment.center,
      height: 40.0,
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.grey, width: 0.5),
          borderRadius: new BorderRadius.circular(30.0)),
      child: new TextField(
        autofocus: false,
        decoration: InputDecoration(
            hintText: "日本",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }

  Widget BuildHomeTab() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _homeTab.map((item) {
            return Ink(
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      Utils.getImgPath(item.imgUrl),
                      width: 48,
                      height: 48,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(item.title))
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }

  TabController _tabController;
  List tabs = [
    "正在旅行",
    "推荐",
    "附近",
    "视频",
    "国内",
    "国外",
    "带娃旅行",
    "海岛游",
    "情侣出行",
    "自驾游"
  ];

  Widget BuildTab() {
    return Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.yellow,
                controller: _tabController,
                labelStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                unselectedLabelStyle:
                    TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
            Center(
              child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_down), onPressed: () {}),
            )
          ],
        ));
  }

  Widget BuildItem() {
    String path1 =
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559730619698&di=b2163c5c2e75fcd0369e011cce5772ce&imgtype=0&src=http%3A%2F%2Fgame.gtimg.cn%2Fimages%2Fdaoju%2Fapp%2Flol%2Fbig%2F2-202001-9.jpg";

    Widget BuildRowChlidFirst() {
      return Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        child: ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 90,
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                      const Color(0xFFFFAEB9),
                      const Color(0xFFFF3030),
                    ],
                    stops: [0.0, 0.9],
                  )),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "热门玩法",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    }

    Widget BuildRowChlid() {
      return Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        child: ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: path1,
                  width: 130,
                  height: 90,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.grey.shade800.withOpacity(0.6),
                  width: 130,
                  height: 90,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "六月去哪儿",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  height: 90,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "16.6万人正在围观",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    }

    Widget BuildContent() {
      return Container(
        margin: EdgeInsets.only(top: 10.0,left: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x4D6E6E6E),
                    offset: Offset(0.0, 3.0) ,
                    blurRadius: 4.0,
                )
              ]

          ),
        child: ClipRRect(
          borderRadius: new BorderRadius.all(new Radius.circular(14.0)),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ItemContent(),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Image.asset('images/mall_home_travel_note_pre.png'),
                    Text("太古里网红打卡",
                        style: TextStyle(color: Colors.lightBlue, fontSize: 12.0))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0,right: 4.0),
                child: Text(
                  "太古里春熙路又非常多的美女小姐姐哦，个个都是贼好看，还有钱，还有大长腿",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                  maxLines: 3,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                        child: CachedNetworkImage(
                          height: 25,
                          width: 25,
                          imageUrl: path1,
                          fit: BoxFit.cover,
                          placeholder: (content, url) => ProgressView(),
                          errorWidget: (content, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Text(
                        "凡事不问的俗人",
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        maxLines: 3,
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset('images/icon_heart_m_s.png',width: 20,height: 20,),
                        )
                      ),
                      Text(" 84",
                          textAlign: TextAlign.right,
                          style:
                          TextStyle(color: Colors.grey,
                              fontSize: 12.0
                          ))
                    ],
                  ))
            ],
          ),
        ),
      );
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                BuildRowChlidFirst(),
                BuildRowChlid(),
                BuildRowChlid(),
                BuildRowChlid(),
                BuildRowChlid(),
                BuildRowChlid(),
                BuildRowChlid(),
                BuildRowChlid(),
                BuildRowChlid()
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(5.0),
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: 29,
            itemBuilder: (BuildContext context, int index) => BuildContent(),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 3 : 3.2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(child: buildBunner(context, _paths)),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 1, child: buildTextField()),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(
                    Utils.getImgPath('icon_message_l'),
                    width: 30,
                    height: 30,
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(child: BuildHomeTab()),
          SliverPersistentHeader(
            delegate: SliverTabBarDelegate(
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.yellow,
                        controller: _tabController,
                        labelStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        unselectedLabelStyle: TextStyle(
                            fontStyle: FontStyle.normal, fontSize: 16),
                        tabs: tabs.map((e) => Tab(text: e)).toList(),
                      ),
                    ),
                    Center(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () {}),
                    )
                  ],
                ),
                color: Colors.white),
            pinned: true,
          )
        ];
      },
      body: TabBarView(
        children: tabs.map((e) {
          return BuildItem();
        }).toList(),
        controller: _tabController,
      ),
    );
  }
}
