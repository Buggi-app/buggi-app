import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/buggi/views/actions/search.dart';
import 'package:app/common_libs.dart';

class BuggiActions extends ConsumerStatefulWidget {
  static const String route = '/buggi/actions';
  final String? offerId;
  const BuggiActions({super.key, this.offerId});

  @override
  ConsumerState<BuggiActions> createState() => _BuggiActionsState();
}

class _BuggiActionsState extends ConsumerState<BuggiActions> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final List<String> availableActions = [
    'Exchange a book',
    'Give a book',
  ];
  List<Book> booksA = [];
  List<Book> booksB = [];
  bool showDiscription = false;
  int action = 0;
  bool loading = true;

  void loadData() {
    Offer myOffer =
        (ref.read(timelineServiceProvider) as AsyncData<List<Section>>)
            .value
            .where((section) => section.offers is AsyncData)
            .expand((section) => section.offers.asData!.value)
            .firstWhere((element) => element.id == widget.offerId);

    _titleController.text = myOffer.title;
    action = myOffer.actions[0];
    booksA = myOffer.ownerBooks.map((e) => e.asData!.value).toList();
    booksB = myOffer.offerBooks.map((e) => e.asData!.value).toList();

    setState(() {
      if (myOffer.description.isNotEmpty) {
        showDiscription = true;
      }
      loading = false;
    });
    _descController.text = myOffer.description;
  }

  void submitOffer() async {
    if (_formKey.currentState!.validate() &&
        booksA.isNotEmpty &&
        booksB.isNotEmpty) {
      setState(() {
        loading = true;
      });
      await FirebaseFirestore.instance.collection('offers').add({
        'title': _titleController.text,
        'actions': [action],
        'grade': booksA.first.grade,
        'owner_id': BuggiAuth.user.uid,
        'owner_email': BuggiAuth.user.email,
        'owner_name': BuggiAuth.user.displayName,
        'owner_avatar': BuggiAuth.user.photoURL,
        'owner_phone': BuggiAuth.user.phoneNumber,
        'my_books': booksA.map((e) => e.id).toList(),
        'needed_books': booksB.map((e) => e.id).toList(),
        'description': _descController.text,
        'created_at': Timestamp.now(),
      });
      ref.read(timelineServiceProvider.notifier).loadOffers().then((value) {
        showToast('Offer added successfully');
        Navigator.pop(context);
      }).onError(
        (error, stackTrace) {
          showToast('Offer not added', isError: true);
          Navigator.pop(context);
        },
      );
    }
  }

  void updateOffer() async {
    if (_formKey.currentState!.validate() &&
        booksA.isNotEmpty &&
        booksB.isNotEmpty) {
      setState(() {
        loading = true;
      });
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(widget.offerId!)
          .update({
        'title': _titleController.text,
        'actions': [action],
        'grade': booksA.first.grade,
        'owner_id': BuggiAuth.user.uid,
        'owner_email': BuggiAuth.user.email,
        'owner_name': BuggiAuth.user.displayName,
        'owner_avatar': BuggiAuth.user.photoURL,
        'owner_phone': BuggiAuth.user.phoneNumber,
        'my_books': booksA.map((e) => e.id).toList(),
        'needed_books': booksB.map((e) => e.id).toList(),
        'description': _descController.text,
      });
      ref.read(timelineServiceProvider.notifier).loadOffers().then((value) {
        showToast('Offer updated successfully');
        Navigator.pop(context);
      }).onError(
        (error, stackTrace) {
          showToast('Offer not updated', isError: true);
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.offerId.isNotNull) {
        loadData();
      } else {
        setState(() => loading = false);
      }
    });
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
        actions: (widget.offerId.isNotNull && !loading)
            ? [
                TextButton.icon(
                  onPressed: updateOffer,
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppTheme.orange),
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text('Save changes'),
                )
              ]
            : null,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: _hintText('I want to :'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: DropdownButton(
                        elevation: 1,
                        underline: const SizedBox.shrink(),
                        dropdownColor: AppTheme.halfOrange,
                        value: availableActions[action],
                        onChanged: (value) {
                          setState(() {
                            action = value == 'Exchange a book' ? 0 : 1;
                          });
                        },
                        items: availableActions
                            .map<DropdownMenuItem<String>>((String value) {
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
                                controller: _descController,
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
                                icon: const Icon(Icons.delete))
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
                    const SizedBox(height: 16)
                  ],
                ),
              ),
            ),
      floatingActionButton: !widget.offerId.isNotNull
          ? FloatingActionButton.extended(
              onPressed: submitOffer,
              label: Row(
                children: const [
                  Text('Submit'),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios, size: 16)
                ],
              ),
            )
          : null,
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
