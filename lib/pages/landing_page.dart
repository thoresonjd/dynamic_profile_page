import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/theme/colors.dart';
import 'package:dynamic_profile_page/pages/edit_profile_page.dart';
import 'package:dynamic_profile_page/pages/home_page.dart';
import 'package:dynamic_profile_page/pages/profile_list_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> tabs = [
    const AddEditProfilePage(),
    const HomePage(),
    const ProfileListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add)),
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.list)),
        ],
        activeColor: AppColors.magenta,
        backgroundColor: AppColors.grey,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                border: Border(),
                transitionBetweenRoutes: false,
                backgroundColor: AppColors.grey,
              ),
              child: tabs[index]
            );
          }
        );
      },
    );
  }
}