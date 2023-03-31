import 'dart:io';
import 'package:app/common_libs.dart';

class EditProfilePage extends StatefulWidget {
  static const route = '/profile/edit';
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  bool imageUploaded = false;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = user.displayName ?? '';
    _phoneController.text = NoSQLDb.phoneNumber ?? '';
  }

  update() async {
    if (_formKey.currentState!.validate()) {
      NoSQLDb.updatePhoneNumber(_phoneController.text);
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(_nameController.text)
          .then(
            (value) => Navigator.pop(context),
          );
    }
  }

  void uploadImage() async {
    var ext = image!.name.split('.').last;
    final metadata = SettableMetadata(contentType: 'image/$ext');
    uploading = true;
    setState(() {});
    final task = FirebaseStorage.instance
        .ref('avatars')
        .child('${BuggiAuth.user.uid}_avatar.$ext')
        .putFile(File(image!.path), metadata);

    task.snapshotEvents.listen((TaskSnapshot snap) async {
      if (snap.state == TaskState.running) {
        task.snapshot.ref.fullPath;
      }
      if (snap.state == TaskState.success) {
        if (!imageUploaded) {
          var url = await task.snapshot.ref.getDownloadURL();
          FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
          imageUploaded = true;
          uploading = false;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: update,
            style: ElevatedButton.styleFrom(foregroundColor: AppTheme.orange),
            child: const Text('Save'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  image.isNotNull
                      ? Container(
                          height: 120,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : !user.photoURL.isNotNull
                          ? CircleAvatar(
                              radius: 40,
                              backgroundColor: AppTheme.orange,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/images/noface.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(
                              height: 120,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                user.photoURL!,
                                fit: BoxFit.cover,
                              ),
                            ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: uploading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.orange,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              image = await _picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image.isNotNull) {
                                uploadImage();
                              }
                            },
                            icon: const Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.white60,
                            ),
                          ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: TextFormField(
                  controller: _nameController,
                  validator: emptyValidation,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: TextFormField(
                  controller: _phoneController,
                  validator: emptyValidation,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
