import 'dart:io';

import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/buggi/views/actions/add_book.dart';
import 'package:app/common_libs.dart';

class BuggiActions extends StatefulWidget {
  static const String route = '/buggi/actions';
  const BuggiActions({super.key});

  @override
  State<BuggiActions> createState() => _BuggiActionsState();
}

class _BuggiActionsState extends State<BuggiActions> {
  List<Book> booksA = [];
  List<Book> booksB = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: _hintText('I want to :'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: DropdownButton(
                elevation: 1,
                underline: const SizedBox.shrink(),
                dropdownColor: AppTheme.halfOrange,
                value: 'Exchange a book',
                onChanged: (value) {},
                items: [
                  'Exchange a book',
                  'Give a book',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('The books I have are :'),
            ),
            ...addSection(booksA),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('General name of this books'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Short description',
                  hintStyle: TextStyle(
                    color: AppTheme.halfGrey,
                    height: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Divider(
              color: AppTheme.halfGrey,
              thickness: 1,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('The books I need are :'),
            ),
            ...addSection(booksB),
            Divider(
              color: AppTheme.halfGrey,
              thickness: 1,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('Any other description'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            children: const [
              Text('Submit'),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward_ios, size: 16)
            ],
          )),
    );
  }

  Widget _hintText(String text) => Text(
        text,
        style: const TextStyle(
          color: AppTheme.orange,
          height: 1,
          fontWeight: FontWeight.bold,
        ),
      );

  List<Widget> addSection(List<Book> bks) {
    return [
      Wrap(
        children: [
          ...bks
              .map(
                (e) => Container(
                  width: 90,
                  height: 120,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(
                        File(e.url),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        bool proceed = await ConfirmationDialog.show(
                          'Remove Image',
                          message: 'Remove this book from the collection',
                        );
                        if (proceed) {
                          setState(() {
                            bks.remove(e);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: AppTheme.halfOrange,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                IconButton(
                  onPressed: () async {
                    var book = await Navigator.of(context).push<Book>(
                      MaterialPageRoute(builder: (_) => const AddBook()),
                    );
                    if (book != null) {
                      setState(() {
                        bks.add(book);
                      });
                    }
                  },
                  icon: SvgPicture.asset(LocalAsset.addBookIcon, width: 26),
                ),
                const Text(
                  'Tap to add a book',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
    ];
  }
}
