import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/db/profile_database.dart';
import 'package:dynamic_profile_page/db/model/profile.dart';
import 'package:dynamic_profile_page/widget/profile_form_widget.dart';

class AddEditProfilePage extends StatefulWidget {
  final Profile? profile;

  const AddEditProfilePage({
    Key? key,
    this.profile,
  }) : super(key: key);
  @override
  _AddEditProfilePageState createState() => _AddEditProfilePageState();
}

class _AddEditProfilePageState extends State<AddEditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.profile?.username ?? '';
    description = widget.profile?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: ProfileFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => 
              setState(() => this.title = title),
            onChangedDescription: (description) =>
              setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
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
      username: title,
      description: description,
    );

    await ProfileDatabase.instance.updateProfile(profile);
  }

  Future addProfile() async {
    final profile = Profile(
      username: title,
      description: description,
      createdTime: DateTime.now(),
    );

    await ProfileDatabase.instance.create(profile);
  }
}
