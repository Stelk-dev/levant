import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:levant/main/account/account.dart';
import 'package:levant/main/home/home.dart';
import 'package:levant/main/favourites/favourite.dart';
import 'package:get/get.dart';
import 'package:levant/main/map/map.dart';
import 'package:levant/main/search/search.dart';
import 'package:levant/main/settings/SettingsPage.dart';
import 'package:levant/management/scrollController.dart';
import 'package:levant/model/modelAccount/profile.dart';
import 'package:levant/model/pageRoute.dart';
import 'package:levant/style/mainStyle.dart';
import 'package:location/location.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final List<RouteBottomModel> pages = [
    RouteBottomModel(route: HomeRoute(), icon: Icons.home, label: ""),
    RouteBottomModel(route: SearchRoute(), icon: Icons.search, label: ""),
    RouteBottomModel(route: FavouriteRoute(), icon: Icons.bookmark, label: ""),
    RouteBottomModel(
        route: AccountRoute(), icon: Icons.account_circle, label: ""),
  ];
  int index = 0;

  final _scrollController = Get.put(ScrollControllerHome());

  @override
  void initState() {
    super.initState();
    _scrollController.initcontroller();
  }

  void navigationAndGetLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      print(_serviceEnabled);

      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    if (_permissionGranted == PermissionStatus.granted)
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MapRoute()));
  }

  @override
  Widget build(BuildContext context) {
    Get.put(Profile()).printDataProfile();

    return Scaffold(
        backgroundColor: MainColorsApp.background_color,
        appBar: AppBar(
          // TODO: Implementing the SliverAppBar for better animation
          title: Text(
            "Levant",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            index == (pages.length - 1)
                ? IconButton(
                    onPressed: () => Navigator.of(context).push(
                        CupertinoPageRoute(builder: (_) => SettingsRoute())),
                    icon: Icon(Icons.settings),
                  )
                : Container(),
          ],
          backgroundColor: MainColorsApp.main_color,
        ),
        body: pages[index].route,
        floatingActionButton: index != 0
            ? Container()
            : FloatingActionButton.extended(
                backgroundColor: MainColorsApp.primary_button_color,
                onPressed: () => navigationAndGetLocation(),
                label: Obx(
                  () => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        child: child,
                        sizeFactor: animation,
                        axis: Axis.horizontal,
                      ),
                    ),
                    child: _scrollController.isScrolled.value
                        ? Icon(Icons.map_outlined)
                        : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.map_outlined),
                              ),
                              Text("Discoteche vicine")
                            ],
                          ),
                  ),
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          unselectedItemColor: Colors.grey.withOpacity(.5),
          selectedItemColor: Colors.white,
          onTap: (i) {
            setState(() => index = i);
          },
          currentIndex: index,
          items: [
            for (var i in pages)
              BottomNavigationBarItem(
                  icon: Icon(i.icon),
                  label: i.label,
                  backgroundColor: MainColorsApp.main_color)
          ],
        ));
  }
}
