import 'package:dynamic_profile_page/pages/profile_display_page.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/db/model/profile.dart';
import 'package:dynamic_profile_page/db/profile_database.dart';
import 'package:dynamic_profile_page/pages/edit_profile_page.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class ProfileListPage extends StatefulWidget {
  const ProfileListPage({ Key? key }) : super(key: key);

  @override
  _ProfileListPageState createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  late List<Profile> profiles;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshProfiles();
  }

  @override dispose() {
    ProfileDatabase.instance.close();
    super.dispose();
  }

  Future refreshProfiles() async {
    setState(() => isLoading = true);
    profiles = await ProfileDatabase.instance.readAllProfiles();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profiles"),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
        ? const CircularProgressIndicator()
        : profiles.isEmpty
          ? const Text("No profiles")
          : buildProfilesList()
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.grey,
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

  Widget buildProfilesList() {
    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfileDisplayPage(profileId: profile.id!)
            ));
            refreshProfiles();
          },

          child: ListTile(
            leading: Text('${profile.id}'),
            title: Text(profile.username)
          )
        );
      }
    );
  }
}