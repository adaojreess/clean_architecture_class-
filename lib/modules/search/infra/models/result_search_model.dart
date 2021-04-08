import 'dart:convert';

import 'package:clean_architecture_class/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String title;
  final String content;
  final String img;

  ResultSearchModel(this.title, this.content, this.img) : super('', '', '');

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'img': img,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      map['login'],
      '${map['id']}',
      map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
