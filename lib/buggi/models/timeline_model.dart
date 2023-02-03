import 'package:app/common_libs.dart';

class Timeline {
  final List<AsyncValue> sections;

  Timeline({required this.sections});

  factory Timeline.loading() {
    return Timeline(
      sections: List.generate(
        5,
        (index) => const AsyncValue.loading(),
      ),
    );
  }

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      sections: json['sections']
          .map<AsyncValue>((section) => AsyncValue.data(section))
          .toList(),
    );
  }
}

class Offer {
  final String id;
  final String title;
  final String description;

  Offer({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
