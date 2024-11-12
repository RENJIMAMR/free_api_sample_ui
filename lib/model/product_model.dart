// To parse this JSON data, do
//
//     final productResMOdel = productResMOdelFromJson(jsonString);

import 'dart:convert';

ProductResMOdel productResMOdelFromJson(String str) =>
    ProductResMOdel.fromJson(json.decode(str));

String productResMOdelToJson(ProductResMOdel data) =>
    json.encode(data.toJson());

class ProductResMOdel {
  String? msg;
  List<ProductModel>? data;

  ProductResMOdel({
    this.msg,
    this.data,
  });

  factory ProductResMOdel.fromJson(Map<String, dynamic> json) =>
      ProductResMOdel(
        msg: json["Msg"],
        data: json["data"] == null
            ? []
            : List<ProductModel>.from(
                json["data"]!.map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? price;
  int? stock;
  String? category;
  dynamic imageUrl;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.category,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category": category,
        "image_url": imageUrl,
      };
}
