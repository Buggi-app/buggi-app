import 'package:app/buggi/models/book.dart';
import 'package:app/buggi/models/timeline_model.dart';
import 'package:app/common_libs.dart';

final timelineServiceProvider =
    StateNotifierProvider<TimelineServiceNotifier, AsyncValue<List<Section>>>(
  (ref) => TimelineServiceNotifier(),
);

class TimelineServiceNotifier extends StateNotifier<AsyncValue<List<Section>>> {
  TimelineServiceNotifier() : super(const AsyncLoading<List<Section>>()) {
    init();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference sectionsCollection =
      firestore.collection('sections');
  late final CollectionReference<Map> offersCollection =
      firestore.collection('offers');
  late final CollectionReference<Map> booksCollection =
      firestore.collection('books');

  updatepull() {
    loadOffers();
  }

  init() async {
    await sectionsCollection.get().then((value) {
      state = AsyncData(value.docs
          .map(
            (e) => Section(
              name: e.id,
              offers: const AsyncLoading<List<Offer>>(),
            ),
          )
          .toList());
      loadOffers();
    }).onError((error, stackTrace) {
      state = AsyncError(error ?? '', stackTrace);
    });
  }

  Future<void> loadOffers() async {
    Iterable<Map<String, dynamic>> allOfers = await fetchAllOffers();

    preLoadOffers(allOfers);

    await loadBooks(allOfers);
  }

  Future<void> loadBooks(Iterable<Map<String, dynamic>> allOfers) async {
    var sections = state.asData!.value;
    for (int i = 0; i < sections.length; i++) {
      var offers = sections[i].offers.asData!.value;
      for (int x = 0; x < offers.length; x++) {
        var ownerBooks = offers[x].ownerBooks;
        var offerBooks = offers[x].offerBooks;

        for (int ob = 0; ob < ownerBooks.length; ob++) {
          String bookId = allOfers.firstWhere(
              (element) => element['id'] == offers[x].id)['ownerBooks'][ob];
          Book loadedBook =
              await booksCollection.doc(bookId).get().then((value) async {
            var dt = value.data()!;
            var image = await FirebaseStorage.instance
                .ref("Books/${dt['cover']}")
                .getDownloadURL();
            return Book(
              id: value.id,
              name: dt['name'],
              cover: image,
              grade: dt['grade'],
              isbn: dt['isbn'],
            );
          });
          var newBooks = ownerBooks;
          newBooks[ob] = AsyncData(loadedBook);
          var newOffers = offers;
          newOffers[x] = newOffers[x].copyWith(ownerBooks: newBooks);
          var newData = state.asData!.value;
          newData[i] = newData[i].copyWith(newOffers);
          state = AsyncData(newData);
        }

        for (int ob = 0; ob < offerBooks.length; ob++) {
          String bookId = allOfers.firstWhere(
              (element) => element['id'] == offers[x].id)['offerBooks'][ob];
          Book loadedBook =
              await booksCollection.doc(bookId).get().then((value) async {
            var dt = value.data()!;
            var image = await FirebaseStorage.instance
                .ref("Books/${dt['cover']}")
                .getDownloadURL();
            return Book(
              id: value.id,
              name: dt['name'],
              cover: image,
              grade: dt['grade'],
              isbn: dt['isbn'],
            );
          });
          var newBooks = offerBooks;
          newBooks[ob] = AsyncData(loadedBook);
          var newOffers = offers;
          newOffers[x] = newOffers[x].copyWith(offerBooks: newBooks);
          var newData = state.asData!.value;
          newData[i] = newData[i].copyWith(newOffers);
          state = AsyncData(newData);
        }
      }
    }
  }

  void preLoadOffers(
    Iterable<Map<String, dynamic>> allOfers,
  ) {
    var sections = state.asData!.value;
    List<Section> newSections = [];
    for (int i = 0; i < sections.length; i++) {
      List<int> getActions(dynamic dd) {
        List d1 = dd;
        List<int> d2 = d1.map((e) => e as int).toList();
        return d2;
      }

      var sectionOffersA = allOfers.map((e) {
        if (sections[i].name == e['grade']) {
          return Offer(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            actions: getActions(e['actions']),
            grade: e['grade'],
            offerBooks: List.generate(
              e['offerBooks'].length,
              (index) => const AsyncLoading(),
            ),
            ownerBooks: List.generate(
              e['ownerBooks'].length,
              (index) => const AsyncLoading(),
            ),
            owner: OfferOwner(
              id: e['owner_id'],
              email: e['owner_email'],
              name: e['owner_name'],
              avatar: e['owner_avatar'],
              phone: e['owner_phone'],
            ),
            createdAt: e['created_at'],
          );
        }
        return null;
      });
      var sectionOffersB = sectionOffersA.whereType<Offer>().toList();
      newSections.add(
        Section(
          name: sections[i].name,
          offers: AsyncData(sectionOffersB),
        ),
      );
    }
    state = AsyncData(newSections);
  }

  Future<Iterable<Map<String, dynamic>>> fetchAllOffers() async {
    var allOfers = await offersCollection.get().then(
      (value) {
        return value.docs.map((e) {
          var dt = e.data();
          return {
            'id': e.id,
            'title': dt['title'],
            'description': dt['description'],
            'actions': dt['actions'],
            'grade': dt['grade'],
            'offerBooks': dt['needed_books'],
            'ownerBooks': dt['my_books'],
            'owner_id': dt['owner_id'],
            'owner_email': dt['owner_email'],
            'owner_name': dt['owner_name'],
            'owner_avatar': dt['owner_avatar'],
            'owner_phone': dt['owner_phone'],
            'created_at': dt['created_at']
          };
        });
      },
    );
    return allOfers;
  }
}
