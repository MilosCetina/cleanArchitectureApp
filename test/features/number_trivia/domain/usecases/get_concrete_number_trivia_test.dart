import 'package:dartz/dartz.dart';
import 'package:hello_world/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:hello_world/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:hello_world/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
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
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    "should get trivia for the number from the repository",
    () async {
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => Right(tNumberTrivia));
      final result = await usecase(Params(number: tNumber));
      print(result);
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
