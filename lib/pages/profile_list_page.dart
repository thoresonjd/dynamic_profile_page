import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dynamic_profile_page/db/profile_database.dart';
import 'package:dynamic_profile_page/db/model/profile.dart';
import 'package:dynamic_profile_page/pages/edit_profile_page.dart';
import 'package:dynamic_profile_page/pages/profile_display_page.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({Key? key}) : super(key: key);

  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  late List<Profile> profiles;
  bool isLoading = false;

  final _listColors = [
    AppColors.red,
    AppColors.orange,
    AppColors.yellow,
    AppColors.lime,
    AppColors.cyan,
    AppColors.magenta,
  ];

  @override
  void initState() {
    super.initState();
    refreshProfiles();
  }

  // @override
  // void dispose() {
  //   ProfileDatabase.instance.close();
  //   super.dispose();
  // }

  Future refreshProfiles() async {
    setState(() => isLoading = true);
    profiles = await ProfileDatabase.instance.readAllProfiles();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profiles',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: isLoading
          ? const CircularProgressIndicator()
          : profiles.isEmpty
            ? const Text(
                'No Profiles',
                style: TextStyle(color: AppColors.white, fontSize: 24),
              )
            : buildProfiles(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditProfilePage()),
          );

          refreshProfiles();
        },
      ),
    );
  }

  Widget buildProfiles() {
    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfileDetailPage(profileId: profile.id!)
            ));
            refreshProfiles();
          },

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              tileColor: _listColors[index % _listColors.length],
              leading: Text('${profile.id}'),
              title: Text(profile.username),
              trailing: Text(DateFormat.yMMMd().format(profile.createdTime))
            ),
          )
        );
      }
    );
  }
  // Widget buildProfiles() => StaggeredGridView.countBuilder(
  //       padding: const EdgeInsets.all(8),
  //       itemCount: profiles.length,
  //       staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
  //       crossAxisCount: 4,
  //       mainAxisSpacing: 4,
  //       crossAxisSpacing: 4,
  //       itemBuilder: (context, index) {
  //         final profile = profiles[index];
  //
  //         return GestureDetector(
  //           onTap: () async {
  //             await Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => ProfileDetailPage(profileId: profile.id!),
  //             ));
  //
  //             refreshProfiles();
  //           },
  //           child: ProfileCardWidget(profile: profile, index: index),
  //         );
  //       },
  //     );
}
