import 'package:flutter/foundation.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final String text;
  final int number;

  NumberTriviaModel({@required this.text, @required this.number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json["text"],
      number: (json["number"] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    var map = {
      "text": text,
      "number": number,
    };
    return map;
  }
}
