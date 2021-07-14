import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getNumberTriviaFromUrl(number.toString());

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTriviaFromUrl("random");

  Future<NumberTriviaModel> _getNumberTriviaFromUrl(String endPoint) async {
    final String kBaseUrl = "http://numbersapi.com/";
    final response = await client.get(
      "$kBaseUrl$endPoint",
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final numberTrivaModel =
          NumberTriviaModel.fromJson(jsonDecode(response.body));
      return numberTrivaModel;
    } else {
      throw ServerException();
    }
  }
}
