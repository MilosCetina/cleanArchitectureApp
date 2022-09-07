import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter{
  Either<Failure, int> stringToUnsignedInteger(String str){
    try{
      final broj = int.parse(str);
      if(broj < 0) throw FormatException();
      return Right(broj);
    } on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure{
  @override
  List<Object?> get props => [];
}