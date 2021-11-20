import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class ProfileFormWidget extends StatelessWidget {
  final String? username;
  final String? description;
  final ValueChanged<String> onChangedUsername;
  final ValueChanged<String> onChangedDescription;

  const ProfileFormWidget({
    Key? key,
    required this.username,
    this.description = '',
    required this.onChangedUsername,
    required this.onChangedDescription
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildUsername(),
            const SizedBox(height: 10.0),
            buildDescription(),
          ]
        )
      )
    );
  }
  Widget buildUsername() => TextFormField(
    maxLines: 1,
    initialValue: username,
    style: const TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Username',
      hintStyle: TextStyle(color: AppColors.grey),
    ),
    validator: (username) =>
        username != null && username.isEmpty ? 'Username cannot be empty' : null,
    onChanged: onChangedUsername,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: AppColors.white, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'About you',
      hintStyle: TextStyle(color: AppColors.grey),
    ),
    // validator: (desc) => desc != null && desc.isEmpty
    //     ? 'The description cannot be empty'
    //     : null,
    onChanged: onChangedDescription,
  );
}