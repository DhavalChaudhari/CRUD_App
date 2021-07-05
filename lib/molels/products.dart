class Products {
  late int id;
  late String name;
  late String desc;
  late int price;
  late String image;
  Products({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.image,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      price: json["price"],
      image: json["image"],
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      "id": id,
      "name": name,
      "decs": desc,
      "price": price,
      "image": image
    };
  }
}
