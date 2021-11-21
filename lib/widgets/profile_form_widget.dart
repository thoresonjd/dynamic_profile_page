import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/theme/colors.dart';

class ProfileFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const ProfileFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const Divider(height: 10, color: AppColors.grey),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: AppColors.grey,
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
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: AppColors.grey, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something about you...',
      hintStyle: TextStyle(color: AppColors.grey),
    ),
    validator: (desc) => desc != null && desc.isEmpty
      ? 'The description cannot be empty'
      : null,
    onChanged: onChangedDescription,
  );
}
