import 'package:dartz/dartz.dart';
import 'package:hello_world/core/error/failures.dart';
import 'package:hello_world/core/platform/network_info.dart';
import 'package:hello_world/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:hello_world/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../data_sources/number_trivia_local_data_source.dart';
import '../data_sources/number_trivia_remote_data_source.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    throw UnimplementedError();
  }

}