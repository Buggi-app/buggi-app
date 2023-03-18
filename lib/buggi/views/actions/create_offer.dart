import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/buggi/views/actions/add_book.dart';
import 'package:app/buggi/views/actions/search.dart';
import 'package:app/common_libs.dart';

class BuggiActions extends StatefulWidget {
  static const String route = '/buggi/actions';
  const BuggiActions({super.key});

  @override
  State<BuggiActions> createState() => _BuggiActionsState();
}

class _BuggiActionsState extends State<BuggiActions> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  List<Book> booksA = [];
  List<Book> booksB = [];
  bool showDiscription = false;
  int action = 0;

  void submitOffer() async {
    if (_formKey.currentState!.validate() &&
        booksA.isNotEmpty &&
        booksB.isNotEmpty) {
      await FirebaseFirestore.instance.collection('offers').add({
        'title': _titleController.text,
        'actions': [action],
        'grade': booksA.first.grade,
        'owner': {
          'id': BuggiAuth.user.uid,
          'email': BuggiAuth.user.email,
          'name': BuggiAuth.user.displayName,
          'avatar': BuggiAuth.user.photoURL,
          'phone': BuggiAuth.user.phoneNumber,
        },
        'my_books': booksA.map((e) => e.id).toList(),
        'needed_books': booksB.map((e) => e.id).toList(),
        'description': _descController.text,
      });
    }
  }

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
        child: Form(
          key: _formKey,
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
                  onChanged: (value) {
                    setState(() {
                      action = value == 'Exchange a book' ? 0 : 1;
                    });
                  },
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
                  validator: emptyValidation,
                  controller: _titleController,
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
              if (showDiscription)
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 5,
                          minLines: 1,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              showDiscription = false;
                            });
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showDiscription = true;
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submitOffer,
        label: Row(
          children: const [
            Text('Submit'),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
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
        crossAxisAlignment: WrapCrossAlignment.center,
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
                      image: NetworkImage(e.cover!),
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
                    var book = await SearchPage.show(context);
                    if (book != null) {
                      setState(() {
                        bks.add(book);
                      });
                    }
                  },
                  icon: SvgPicture.asset(LocalAsset.addBookIcon, width: 26),
                ),
                const Text(
                  'Tap to add\na book',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
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
