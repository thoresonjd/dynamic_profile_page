import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_profile_page/pages/profile_list_page.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const DynamicProfilePageApp());
}

class DynamicProfilePageApp extends StatelessWidget {
  static const String title = 'Dynamic Profile Page App';

  const DynamicProfilePageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: AppColors.black,
          scaffoldBackgroundColor: AppColors.darkGrey,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.invis,
            elevation: 0,
          ),
        ),
        home: const ProfilesPage(),
      );
}
