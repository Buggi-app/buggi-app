import 'package:app/buggi/models/book.dart';
import 'package:app/common_libs.dart';

final bookStreamProvider = StreamProvider(
  (ref) => FirebaseFirestore.instance.collection('books').snapshots().asyncMap(
        (event) => event.docs.map((e) {
          var bd = e.data();
          return Book(
            id: e.id,
            cover: bd['cover'],
            name: bd['name'],
            grade: bd['grade'],
            isbn: bd['isbn'],
          );
        }).toList(),
      ),
);

class SearchPage extends SearchDelegate<Book?> {
  static Future<Book?> show(BuildContext context) async =>
      await showSearch<Book?>(context: context, delegate: SearchPage());

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          scaffoldBackgroundColor: AppTheme.halfOrange,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppTheme.halfOrange,
            elevation: 0,
          ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return searchResults();
  }

  Widget searchResults() {
    return Consumer(
      builder: (context, ref, _) {
        final booksStream = ref.watch(bookStreamProvider);
        return booksStream.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const Center(child: Text('Error')),
          data: (data) {
            var searchResults = data
                .where((element) => element.name.toLowerCase().contains(query))
                .take(5);
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 18,
                bottom: 16,
              ),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                Book book = searchResults.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      close(context, book);
                    },
                    child: Container(
                      color: Colors.white.withOpacity(.6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(),
                        leading: book.cover.isNotNull
                            ? Image.network(
                                book.cover!,
                                height: 100,
                                width: 60,
                                fit: BoxFit.cover,
                              )
                            : null,
                        title: Text(book.name),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
