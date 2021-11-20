import 'package:dynamic_profile_page/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/db/model/profile.dart';
import 'package:dynamic_profile_page/db/profile_database.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class ProfileDisplayPage extends StatefulWidget {
  const ProfileDisplayPage({ Key? key, required this.profileId }) : super(key: key);

  final int profileId;

  @override
  _ProfileDisplayPageState createState() => _ProfileDisplayPageState();
}

class _ProfileDisplayPageState extends State<ProfileDisplayPage> {
  late Profile profile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshProfile();
  }

  Future refreshProfile() async {
    setState(() => isLoading = true);
    profile = await ProfileDatabase.instance.readProfile(widget.profileId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          editButton(),
          deleteButton()
        ],
      ),
      body: isLoading
      ? const Center(child: CircularProgressIndicator())
      : ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 110.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/saturn_cas_lrg.jpg"),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Divider(
                            color: AppColors.transparent,
                            height: 30.0
                          ),
                          Center(
                            child: Text(
                              profile.username,
                              style: const TextStyle(
                                color: AppColors.magenta,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0
                              )
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          const Text(
                            "ABOUT",
                            style: TextStyle(
                              color: AppColors.grey,
                              letterSpacing: 2.0
                            )
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            profile.description,
                            style: const TextStyle(
                              color: AppColors.magenta,
                              letterSpacing: 2.0,
                              fontSize: 15.0
                            )
                          ),
                          const SizedBox(height: 30.0),
                          const Text(
                            "INFO",
                            style: TextStyle(
                              color: AppColors.grey,
                              letterSpacing: 2.0
                            )
                          ),
                          const SizedBox(width: 10.0),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/icons/icons8-github-30.png", 
                                color: AppColors.white,
                                scale: 1.2
                              ),
                              const SizedBox(width: 10.0),
                              const Text(
                                "thoresonjd",
                                style: TextStyle(
                                  color: AppColors.magenta,
                                  letterSpacing: 2.0,
                                  fontSize: 15.0
                                )
                              ),
                            ],
                          ),
                          const SizedBox(width: 10.0),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/icons/icons8-linkedin-30.png", 
                                color: AppColors.white,
                                scale: 1.2,
                              ),
                              const SizedBox(width: 10.0),
                              const Text(
                                "/justinthoreson",
                                style: TextStyle(
                                  color: AppColors.magenta,
                                  letterSpacing: 2.0,
                                  fontSize: 15.0
                                )
                              ),
                            ],
                          ),
                          Row(
                            children: const <Widget>[
                              Icon(Icons.mail),
                              SizedBox(width: 10.0),
                              Text(
                                "mail@mail.com",
                                style: TextStyle(
                                  color: AppColors.magenta,
                                  letterSpacing: 2.0,
                                  fontSize: 15.0
                                )
                              ),
                            ],
                          ),
                          const SizedBox(width: 10.0),
                          Row(
                            children: const <Widget>[
                              Icon(Icons.camera_alt),
                              SizedBox(width: 10.0),
                              Text(
                                "Insta: @handle",
                                style: TextStyle(
                                  color: AppColors.magenta,
                                  letterSpacing: 2.0,
                                  fontSize: 15.0
                                )
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  top: 55,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 55.0,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/justin_su_id.jpg"),
                      radius: 50.0
                    ),
                  )
                ),
              ]
            ),
          ],
      )
    );
  }

  Widget editButton() => IconButton(
    icon: const Icon(Icons.edit),
    onPressed: () async {
      if (isLoading) return;

      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AddEditProfilePage()
      ));

      refreshProfile();
    }
  );

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await ProfileDatabase.instance.deleteProfile(widget.profileId);
      Navigator.of(context).pop();
    },
  );
}

// class ProfileDisplayPage extends StatelessWidget {
//   const ProfileDisplayPage({ Key? key }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//               Column(
//                 children: [
//                   Container(
//                     height: 110.0,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage("assets/images/saturn_cas_lrg.jpg"),
//                         fit: BoxFit.cover
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         const Divider(
//                           color: AppColors.transparent,
//                           height: 30.0
//                         ),
//                         // const Text(
//                         //   "NAME",
//                         //   style: TextStyle(
//                         //     color: AppColors.grey,
//                         //     letterSpacing: 2.0
//                         //   )
//                         // ),
//                         const Center(
//                           child: Text(
//                             "Justin Thoreson",
//                             style: TextStyle(
//                               color: AppColors.magenta,
//                               letterSpacing: 2.0,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 28.0
//                             )
//                           ),
//                         ),
//                         const SizedBox(height: 30.0),
//                         const Text(
//                           "ABOUT",
//                           style: TextStyle(
//                             color: AppColors.grey,
//                             letterSpacing: 2.0
//                           )
//                         ),
//                         const SizedBox(height: 10.0),
//                         const Text(
//                           "I love the PNW!",
//                           style: TextStyle(
//                             color: AppColors.magenta,
//                             letterSpacing: 2.0,
//                             fontSize: 15.0
//                           )
//                         ),
//                         const SizedBox(height: 30.0),
//                         const Text(
//                           "INFO",
//                           style: TextStyle(
//                             color: AppColors.grey,
//                             letterSpacing: 2.0
//                           )
//                         ),
//                         const SizedBox(width: 10.0),
//                         Row(
//                           children: <Widget>[
//                             Image.asset(
//                               "assets/icons/icons8-github-30.png", 
//                               color: AppColors.white,
//                               scale: 1.2
//                             ),
//                             const SizedBox(width: 10.0),
//                             const Text(
//                               "thoresonjd",
//                               style: TextStyle(
//                                 color: AppColors.magenta,
//                                 letterSpacing: 2.0,
//                                 fontSize: 15.0
//                               )
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 10.0),
//                         Row(
//                           children: <Widget>[
//                             Image.asset(
//                               "assets/icons/icons8-linkedin-30.png", 
//                               color: AppColors.white,
//                               scale: 1.2,
//                             ),
//                             const SizedBox(width: 10.0),
//                             const Text(
//                               "/justinthoreson",
//                               style: TextStyle(
//                                 color: AppColors.magenta,
//                                 letterSpacing: 2.0,
//                                 fontSize: 15.0
//                               )
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: const <Widget>[
//                             Icon(Icons.mail),
//                             SizedBox(width: 10.0),
//                             Text(
//                               "mail@mail.com",
//                               style: TextStyle(
//                                 color: AppColors.magenta,
//                                 letterSpacing: 2.0,
//                                 fontSize: 15.0
//                               )
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 10.0),
//                         Row(
//                           children: const <Widget>[
//                             Icon(Icons.camera_alt),
//                             SizedBox(width: 10.0),
//                             Text(
//                               "Insta: @handle",
//                               style: TextStyle(
//                                 color: AppColors.magenta,
//                                 letterSpacing: 2.0,
//                                 fontSize: 15.0
//                               )
//                             ),
//                           ],
//                         ),
//                       ]
//                     ),
//                   ),
//                 ],
//               ),
//               const Positioned(
//                 top: 55,
//                 child: CircleAvatar(
//                   backgroundColor: AppColors.white,
//                   radius: 55.0,
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage("assets/images/justin_su_id.jpg"),
//                     radius: 50.0
//                   ),
//                 )
//               ),
//             ]
//           ),
//         ],
//       )
//     );
//   }
// }