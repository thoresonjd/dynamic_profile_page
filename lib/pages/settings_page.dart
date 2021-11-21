import 'package:flutter/material.dart';

import 'about_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget> [
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AboutPage())
            );
          },
        )
      ],
    );
  }
}