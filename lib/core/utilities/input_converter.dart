import 'package:dartz/dartz.dart';

import '../error/failure.dart';

class InputConverter {
  Either<Failure, int> numberStringToInt(String str) {
    try {
      int intNumber = int.parse(str);
      if (intNumber < 0) throw FormatException;
      return Right(intNumber);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
