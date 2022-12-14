import 'dart:convert';

import 'package:hello_world/core/error/exceptions.dart';
import 'package:hello_world/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:hello_world/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any as Uri, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any as Uri, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture("trivia.json")));

    test(
        "should perform a GET request on a URL with number being the endpoint and with application/json header ",
        () async {
      setUpMockHttpClientSuccess200();
      dataSource.getConcreteNumberTrivia(tNumber);
      final url = Uri.parse("http://numbersapi.com/$tNumber");
      verify(mockHttpClient.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test("should return NumberTrivia when the response code is 200 (success)",
        () async {
      setUpMockHttpClientSuccess200();
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        "should throw a ServerException when the response code is 404 or other",
        () async {
      setUpMockHttpClientFailure404();
      final call = dataSource.getConcreteNumberTrivia;
      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group("getRandomNumberTrivia", () {
    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode(fixture("trivia.json")));

    test(
        "should perform a GET request on a URL with number being the endpoint and with application/json header ",
            () async {
          setUpMockHttpClientSuccess200();
          dataSource.getRandomNumberTrivia();
          final url = Uri.parse("http://numbersapi.com/random");
          verify(mockHttpClient.get(
            url,
            headers: {'Content-Type': 'application/json'},
          ));
        });

    test("should return NumberTrivia when the response code is 200 (success)",
            () async {
          setUpMockHttpClientSuccess200();
          final result = await dataSource.getRandomNumberTrivia();
          expect(result, equals(tNumberTriviaModel));
        });

    test(
        "should throw a ServerException when the response code is 404 or other",
            () async {
          setUpMockHttpClientFailure404();
          final call = dataSource.getRandomNumberTrivia;
          expect(
                  () => call(), throwsA(const TypeMatcher<ServerException>()));
        });
  });
}
