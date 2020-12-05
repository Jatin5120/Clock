import 'package:clock_app/data/data.dart';
import 'package:clock_app/models/menu_item.dart';
import 'package:clock_app/models/models.dart';
import 'package:clock_app/screens/screens.dart';
import 'package:clock_app/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  MyTheme myTheme;
  AnimationController rotationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    myTheme = Provider.of<MyTheme>(context, listen: false);
    myTheme.setPreference();
    rotationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animation =
        CurvedAnimation(parent: rotationController, curve: Curves.easeInOut);
    askLocationPermission();
  }

  askLocationPermission() async {
    if (!(await Permission.location.isGranted)) {
      await Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageStorageKey('home'),
      floatingActionButton: RotationTransition(
        turns: animation,
        child: FloatingActionButton(
          mini: true,
          child: Icon(Icons.brightness_6_rounded),
          tooltip: 'Change Theme',
          elevation: 0,
          onPressed: () {
            myTheme.changeTheme();
            if (rotationController.value == 0.0)
              rotationController.forward();
            else
              rotationController.reverse();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuItem) => buildMenuButton(currentMenuItem))
                .toList(),
          ),
          VerticalDivider(
            width: 1,
            color: myTheme.isDark ? CustomColors.dividerColorDark : CustomColors.dividerColorLight,
          ),
          Expanded(
            child: Consumer<MenuItem>(
              builder: (BuildContext context, MenuItem menuItem, Widget child) {
                switch (menuItem.menuType) {
                  case MenuType.clock:
                    return ChangeNotifierProvider(
                      create: (BuildContext context) => ClockTimeNow(),
                      child: ClockScreen(isDark: myTheme.isDark),
                    );
                    break;
                  case MenuType.alarm:
                    return AlarmScreen(isDark: myTheme.isDark);
                    break;
                  case MenuType.timer:
                    return ChangeNotifierProvider(
                      create: (BuildContext context) => TimerTime(),
                      child: TimerScreen(isDark: myTheme.isDark),
                    );
                    break;
                  case MenuType.stopwatch:
                    return ChangeNotifierProvider(
                      create: (BuildContext context) => StopWatchTime(),
                      child: StopWatchScreen(isDark: myTheme.isDark),
                    );
                    break;
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuItem currentMenuItem) {
    return Consumer<MenuItem>(
      builder: (BuildContext context, MenuItem menuItem, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          color: currentMenuItem.menuType == menuItem.menuType
              ? myTheme.isDark
                  ? CustomColors.menuBackgroundColorDark
                  : CustomColors.menuBackgroundColorLight
              : Colors.transparent,
          onPressed: () => menuItem.updateMenu(currentMenuItem),
          child: Column(
            children: [
              SvgPicture.asset(
                currentMenuItem.image,
                color: currentMenuItem.menuType == menuItem.menuType
                    ? myTheme.isDark
                        ? CustomColors.activeIconColorDark
                        : CustomColors.activeIconColorLight
                    : myTheme.isDark
                        ? CustomColors.inactiveIconColorDark
                        : CustomColors.inactiveIconColorLight,
                height: 50,
                semanticsLabel: currentMenuItem.image,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                currentMenuItem.title ?? '',
                style: TextStyle(
                  color: currentMenuItem.menuType == menuItem.menuType
                      ? myTheme.isDark
                          ? CustomColors.activeIconColorDark
                          : CustomColors.activeIconColorLight
                      : myTheme.isDark
                          ? CustomColors.inactiveIconColorDark
                          : CustomColors.inactiveIconColorLight,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
