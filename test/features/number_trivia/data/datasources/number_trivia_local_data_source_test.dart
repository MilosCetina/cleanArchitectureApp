import 'dart:convert';

import 'package:hello_world/core/error/exceptions.dart';
import 'package:hello_world/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:hello_world/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group("getLastNumberTrivia", () {
    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
        "should return NumberTrivia from SharedPreferences when there is one in the cached",
            () async {
          when(mockSharedPreferences.getString(any as String))
              .thenReturn(fixture('trivia_cached.json'));
          final result = await dataSource.getLastNumberTrivia();
          verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
          expect(result, equals(tNumberTriviaModel));
        });

    test("should throw a CacheException when there is not a cached value",
            () async {
          when(mockSharedPreferences.getString(any as String)).thenReturn(null);
          final call = dataSource.getLastNumberTrivia;
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        });
  });

  group("cacheNumberTrivia", () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text',);

    test("should call SharedPreferences to cache the data", () async {
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}
