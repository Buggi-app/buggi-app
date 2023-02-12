import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  static const route = '/profile/edit';
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
    );
  }
}
