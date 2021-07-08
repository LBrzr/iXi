class Category {
  final int id;
  final String name, description;

  Category._(this.id, this.name, this.description);
  factory Category.fromJson(Map<String, dynamic> data) => Category._(data['id'], data['name'], data['description']);
}