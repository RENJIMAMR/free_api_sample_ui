// To parse this JSON data, do
//
//     final loginResMOdel = loginResMOdelFromJson(jsonString);

import 'dart:convert';

LoginResMOdel loginResMOdelFromJson(String str) => LoginResMOdel.fromJson(json.decode(str));

String loginResMOdelToJson(LoginResMOdel data) => json.encode(data.toJson());

class LoginResMOdel {
    String? refresh;
    String? access;
    int? id;
    String? name;
    String? place;
    String? email;

    LoginResMOdel({
        this.refresh,
        this.access,
        this.id,
        this.name,
        this.place,
        this.email,
    });

    factory LoginResMOdel.fromJson(Map<String, dynamic> json) => LoginResMOdel(
        refresh: json["refresh"],
        access: json["access"],
        id: json["id"],
        name: json["name"],
        place: json["place"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "id": id,
        "name": name,
        "place": place,
        "email": email,
    };
}
