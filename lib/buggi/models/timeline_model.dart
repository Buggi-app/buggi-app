import 'package:app/buggi/models/book.dart';
import 'package:app/common_libs.dart';

class Section {
  Section({required this.name, required this.offers});
  final String name;
  final AsyncValue<List<Offer>> offers;

  Section copyWith(List<Offer>? offers) {
    return Section(
      name: name,
      offers: offers.isNotNull ? AsyncData(offers!) : this.offers,
    );
  }
}

class Offer {
  final String id;
  final List<int> actions;
  final String title;
  final String description;
  final String grade;
  final List<AsyncValue<Book>> ownerBooks;
  final List<AsyncValue<Book>> offerBooks;
  final OfferOwner owner;

  Offer(
      {required this.id,
      required this.title,
      required this.description,
      required this.actions,
      required this.grade,
      required this.offerBooks,
      required this.ownerBooks,
      required this.owner});

  Offer copyWith(
      {List<AsyncValue<Book>>? ownerBooks,
      List<AsyncValue<Book>>? offerBooks}) {
    return Offer(
      id: id,
      title: title,
      description: description,
      actions: actions,
      grade: grade,
      offerBooks: offerBooks ?? this.offerBooks,
      ownerBooks: ownerBooks ?? this.ownerBooks,
      owner: owner,
    );
  }

  // factory Offer.fromJson(Map<String, dynamic> json) {
  //   return Offer(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //   );
  // }
}

class OfferOwner {
  OfferOwner({
    required this.id,
    required this.email,
    this.avatar,
    this.name,
    this.phone,
  });
  final String id;
  final String? name;
  final String email;
  final String? avatar;
  final String? phone;
}

class OfferOwnerMeta {
  OfferOwnerMeta({required this.email, this.avatar, this.name});
  final String? name;
  final String email;
  final String? avatar;
}
