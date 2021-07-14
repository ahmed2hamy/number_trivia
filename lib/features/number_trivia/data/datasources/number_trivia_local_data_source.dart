import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

const String kCachedNumberTrivia = "kCachedNumberTrivia";

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences prefs;

  NumberTriviaLocalDataSourceImpl({@required this.prefs});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final cachedJsonTrivia = prefs.getString(kCachedNumberTrivia);
    if (cachedJsonTrivia != null) {
      final numberTrivia =
          NumberTriviaModel.fromJson(jsonDecode(cachedJsonTrivia));
      return Future.value(numberTrivia);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return prefs.setString(
      kCachedNumberTrivia,
      jsonEncode(triviaToCache.toJson()),
    );
  }
}
