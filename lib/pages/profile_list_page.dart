import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/db/model/profile.dart';
import 'package:dynamic_profile_page/db/profile_database.dart';

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
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          
          return GestureDetector(
            onTap: () async {
              refreshProfiles();
            },

            child: ListTile(
              leading: Text('${profile.id}'),
              title: Text(profile.username)
            )
          );
        }
      )
    );
  }
}