class Book {
  String? title;
  String? subtitle;
  String? price;
  String? imageUrl;
  String? author;
  String? pdf;

  Book({this.title, this.subtitle, this.price, this.imageUrl, this.author, this.pdf});

  Book.fromJson(Map book) {
    title = book['title'] ?? "";
    subtitle = book['subtitle'] ?? "";
    price = book['price'] ?? "";
    imageUrl = book['image'] ?? "";
    author = book['author'] ?? "";
    pdf = book['pdf'] ?? "";
  }

  toJson() {
    return {'title': title, 'subtitle': subtitle, 'price': price, 'image': imageUrl, 'author': author, 'pdf': pdf};
  }
}
