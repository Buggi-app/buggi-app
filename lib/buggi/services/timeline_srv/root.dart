import 'package:app/buggi/models/timeline.dart';
import 'package:app/common_libs.dart';

final timelineServiceProvider = StateNotifierProvider(
  (ref) => TimelineServiceNotifier(),
);

class TimelineServiceNotifier extends StateNotifier<Timeline> {
  TimelineServiceNotifier() : super(Timeline.loading());
}
