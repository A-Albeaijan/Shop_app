import 'package:flutter/material.dart';

class HomeModel {
  bool? status;

  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List banners = [];
  List products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(element);
    });
    json['products'].forEach((element) {
      products.add(element);
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  var price;
  var old_price;
  var discount;
  String? image;
  String? name;

  bool? in_favorites;
  bool? in_cart;
  ProductModel.fromJson(Map json) {
    discount = json['discount'];
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
