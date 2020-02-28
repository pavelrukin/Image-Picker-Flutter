import 'dart:convert';

import 'package:flutter_test_image_picker/api/webService.dart';
import 'package:flutter_test_image_picker/util/const.dart';


class DataResponse {
  String description;
  String alt_description;
  Urls urls;
  User user;

  DataResponse({this.description, this.alt_description, this.urls, this.user});

  factory DataResponse.fromJson(Map<String, dynamic> parsedJson) {
    return DataResponse(
        description: parsedJson['description'],
        alt_description: parsedJson['alt_description'],
        urls: Urls.fromJson(parsedJson['urls']),
        user: User.fromJson(parsedJson['user']));
  }

  static Resource<List<DataResponse>> get all {
    return Resource(
        url: Constants.UNSPLASH_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((parsedJson) => DataResponse.fromJson(parsedJson)).toList();
        }

    );
  }
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  factory Urls.fromJson(Map<String, dynamic> parsedJson) {
    return Urls(
        raw: parsedJson['raw'],
        full: parsedJson['full'],
        regular: parsedJson['regular'],
        small: parsedJson['small'],
        thumb: parsedJson['thumb']);
  }
}

class User {
  String name;

  User({this.name});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(name: parsedJson['name']);
  }
}
