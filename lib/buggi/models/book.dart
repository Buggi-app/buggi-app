class Book {
  final String id;
  final String? cover;
  final String name;
  final String grade;
  final String? isbn;

  Book({
    required this.id,
    this.cover,
    required this.name,
    required this.grade,
    this.isbn,
  });
}
