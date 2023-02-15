import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  static const route = '/profile/edit';
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(foregroundColor: AppTheme.orange),
            child: const Text('Save'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          children: [
            Image.asset(
              "assets/images/demo/c_face.png",
              width: context.width * .2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: TextFormField(
                validator: emptyValidation,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: TextFormField(
                validator: emptyValidation,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
