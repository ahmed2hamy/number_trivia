part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class ConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;

  ConcreteNumberTriviaEvent({@required this.numberString});

  @override
  List<Object> get props => [this.numberString];
}

class RandomNumberTriviaEvent extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
