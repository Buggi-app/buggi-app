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
  late final CollectionReference sections = firestore.collection('sections');

  init() async {
    await sections.get().then((value) {
      state = AsyncData(value.docs
          .map((e) => Section(name: e.id, offers: const AsyncLoading()))
          .toList());
    }).onError((error, stackTrace) {
      state = AsyncError(error ?? '', stackTrace);
    });
    loadOffers();
  }

  loadOffers() {}
}
