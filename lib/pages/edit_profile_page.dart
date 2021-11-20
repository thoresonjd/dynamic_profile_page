import 'package:dynamic_profile_page/widgets/profile_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/db/model/profile.dart';
import 'package:dynamic_profile_page/db/profile_database.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class AddEditProfilePage extends StatefulWidget {
  const AddEditProfilePage({ Key? key, this.profile}) : super(key: key);

  final Profile? profile;

  @override
  _AddEditProfilePageState createState() => _AddEditProfilePageState();
}

class _AddEditProfilePageState extends State<AddEditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String description;

  @override
  void initState() {
    super.initState();
    username = widget.profile?.username ?? '';
    description = widget.profile?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildButton()
        ]
      ),
      body: Form(
        key: _formKey,
        child: ProfileFormWidget(
          username: username,
          description: description,
          onChangedUsername: (username) =>
            setState(() => this.username = username),
          onChangedDescription: (description) =>
            setState(() => this.description = description),
        )
      )
    );
  }

  Widget buildButton() {
    final isFormValid = username.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: AppColors.white,
          primary: isFormValid ? null : AppColors.white,
        ),
        onPressed: addOrUpdateProfile,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateProfile() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.profile != null;

      if (isUpdating) {
        await updateProfile();
      } else {
        await addProfile();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateProfile() async {
    final profile = widget.profile!.copy(
      username: username,
      description: description,
    );

    await ProfileDatabase.instance.updateProfile(profile);
  }

  Future addProfile() async {
    final profile = Profile(
      username: username,
      description: description,
    );

    await ProfileDatabase.instance.create(profile);
  }
}