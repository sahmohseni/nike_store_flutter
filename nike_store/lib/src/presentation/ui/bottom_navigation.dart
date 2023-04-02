import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/src/presentation/ui/cart/cart.dart';
import 'package:nike_store/src/presentation/ui/home/home.dart';
import 'package:nike_store/theme.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey
  };
  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      selectedScreenIndex != _history.last;
      _history.removeLast();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: sort_child_properties_last
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _Navigator(_homeKey, homeIndex, HomeScreen()),
              _Navigator(_cartKey, cartIndex, CartScreen()),
              _Navigator(_profileKey, profileIndex, Text('profile'))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              onTap: (selectedIndex) {
                setState(() {
                  _history.remove(selectedScreenIndex);
                  _history.add(selectedScreenIndex);
                  selectedScreenIndex = selectedIndex;
                });
              },
              currentIndex: selectedScreenIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                  ),
                  label: 'خانه',
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart),
                    label: 'سبد خرید',
                    backgroundColor: LightTheme.itemBackGroundColor),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled),
                    label: 'پروفایل'),
              ]),
        ),
        onWillPop: _onWillPop);
  }

  Widget _Navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedScreenIndex != index,
                child: child,
              ),
            ),
          );
  }
}
