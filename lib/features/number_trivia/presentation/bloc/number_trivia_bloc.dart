import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/error_messages.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utilities/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concreteNumberTrivia;
  final GetRandomNumberTrivia randomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.concreteNumberTrivia,
    @required this.randomNumberTrivia,
    @required this.inputConverter,
  })  : assert(concreteNumberTrivia != null),
        assert(randomNumberTrivia != null),
        assert(inputConverter != null);

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is ConcreteNumberTriviaEvent) {
      final inputEither = inputConverter.numberStringToInt(event.numberString);
      yield* inputEither.fold((failure) async* {
        yield Error(message: _getErrorMessage(failure));
      }, (integer) async* {
        yield Loading();
        final trivia = await concreteNumberTrivia(Params(number: integer));
        yield* _getTriviaState(trivia);
      });
    } else if (event is RandomNumberTriviaEvent) {
      yield Loading();
      final trivia = await randomNumberTrivia(NoParams());
      yield* _getTriviaState(trivia);
    }
  }

  Stream<NumberTriviaState> _getTriviaState(
      Either<Failure, NumberTrivia> either) async* {
    yield either.fold(
      (failure) => Error(message: _getErrorMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
