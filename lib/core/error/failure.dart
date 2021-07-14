import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List proprties;
  Failure([this.proprties = const <dynamic>[]]);

  @override
  List<Object> get props => [proprties];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class InvalidInputFailure extends Failure {}
