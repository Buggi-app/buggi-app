import 'dart:io';

import 'package:app/buggi/models/models.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/common_libs.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final ImagePicker _picker = ImagePicker();
  File? coverImage;
  final TextEditingController _textEditingController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close_rounded),
        ),
        title: const Text('Add a book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Book name'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _textEditingController,
                validator: emptyValidation,
                maxLines: 2,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: 'SOUND AND READ BOOK 1',
                  hintMaxLines: 2,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 28),
              const Text('Book image'),
              const SizedBox(height: 8),
              if (coverImage == null)
                Container(
                  height: context.height / 2.5,
                  width: context.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: _addImage,
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_photo_alternate_outlined),
                        Text('Tap to add an image')
                      ],
                    ),
                  ),
                )
              else
                InkWell(
                  onTap: _addImage,
                  child: Image.file(
                    coverImage!,
                    height: context.height / 2.5,
                    alignment: Alignment.topCenter,
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: coverImage == null
          ? null
          : FloatingActionButton.extended(
              onPressed: _addBook,
              label: const Text('Add'),
            ),
    );
  }

  _addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        coverImage = File(image.path);
      });
    }
  }

  _addBook() {
    if (_form.currentState!.validate()) {
      var book = Book(url: coverImage!.path, name: _textEditingController.text);
      Navigator.of(context).pop(book);
    }
  }
}
