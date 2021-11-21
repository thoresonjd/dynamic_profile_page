import 'package:dynamic_profile_page/db/profile_database.dart';
import 'package:dynamic_profile_page/pages/home_page.dart';
import 'package:dynamic_profile_page/pages/profile_list_page.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;
  Widget screen = const HomePage();

  @override
  void dispose() {
    ProfileDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
            currentIndex: currentIndex,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: AppColors.magenta,
            unselectedItemColor: AppColors.grey,
            onTap: (value) {
              currentIndex = value;

              switch(currentIndex){
                case 0:
                  screen = const HomePage();
                  break;
                case 1:
                  screen = const ProfilesPage();
                  break;
              }

              setState(() {});
            },                                               
            items: const <BottomNavigationBarItem>[                                        
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),               
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Profiles')                
            ],                                                                       
          ),                                                                         
        )                                                                            
      ),
      body: SafeArea(
        child: screen
      ),
    );
    // final PageController controller = PageController(initialPage: 1);
    // return PageView(
    //   scrollDirection: Axis.horizontal,
    //   controller: controller,
    //   children: const <Widget>[
    //     HomePage(),
    //     ProfilesPage(),
    //   ],
    // );
  }
}