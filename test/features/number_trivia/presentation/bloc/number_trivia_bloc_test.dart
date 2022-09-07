import 'package:hello_world/core/util/input_converter.dart';
import 'package:hello_world/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:hello_world/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:hello_world/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:hello_world/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  // test("initialState should be Empty", () {
  //   expect(bloc.initialState, equals(Empty()));
  // });
  group("GetTriviaForConcreteNumber", () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(text: "test trivia", number: 1);

    test(
        "should call the InputConverter to validate and convert the string to an unsigned integer",
        () async {
      when(mockInputConverter.stringToUnsignedInteger(any as String))
          .thenReturn(Right(tNumberParsed));
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(
          mockInputConverter.stringToUnsignedInteger(any as String));
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });
  });
}
