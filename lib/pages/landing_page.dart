import 'package:dynamic_profile_page/db/profile_database.dart';
import 'package:dynamic_profile_page/pages/home_page.dart';
import 'package:dynamic_profile_page/pages/profile_list_page.dart';
import 'package:dynamic_profile_page/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<String> _pageTitles = [
    'Settings', 'Home', 'Profiles',
  ];

  // Track current page for PageView and BottomNavBar
  int _currentPageIndex = 1;
  final PageController pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    ProfileDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentPageIndex]), // Update AppBar title to current page
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30)
          )
        ),
      ),
      bottomNavigationBar: Container(                                             
        decoration: const BoxDecoration(                                                   
          borderRadius: BorderRadius.only(                                           
            topRight: Radius.circular(30), 
            topLeft: Radius.circular(30)
          ),            
          boxShadow: [                                                               
            BoxShadow(
              color: AppColors.black, 
              spreadRadius: 0, 
              blurRadius: 10
            ),       
          ],                                                                         
        ),                                                                           
        child: ClipRRect(                                                            
          borderRadius: const BorderRadius.only(                                           
            topLeft: Radius.circular(30.0),                                            
            topRight: Radius.circular(30.0),                                           
          ),                                                                         
          child: BottomNavigationBar(
            currentIndex: _currentPageIndex,
            onTap: _onTap,                                              
            items: const <BottomNavigationBarItem>[          
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),                              
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),               
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Profiles')                
            ],
          ),
        )
      ),
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          SettingsPage(),
          HomePage(),
          ProfilesPage()
        ],
        onPageChanged: _onPageChanged
      )
    );
  }

  // Update PageView on BottomNavBar change
  void _onTap(int value) {
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutSine
    );
  }

  // Update BottomNavBar on PageView change
  void _onPageChanged(int value) {
    setState(() {
      _currentPageIndex = value;
    });
  }
}