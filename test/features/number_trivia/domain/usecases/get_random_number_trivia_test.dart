import 'package:dartz/dartz.dart';
import 'package:hello_world/core/usecases/usecase.dart';
import 'package:hello_world/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:hello_world/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:hello_world/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {
  //@override
  // Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number) {
  //   return super.noSuchMethod(Invocation.method(#start, [number]));
  // }

}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    "should get trivia for the number from the repository",
    () async {
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));
      final result = await usecase(NoParams());
      print(result);
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
