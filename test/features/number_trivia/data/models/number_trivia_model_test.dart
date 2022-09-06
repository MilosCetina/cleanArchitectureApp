import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:hello_world/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      //assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );
}
