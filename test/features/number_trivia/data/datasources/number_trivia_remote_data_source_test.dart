import 'package:hello_world/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
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

  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    test(
        "should perform a GET request on a URL with number being the endpoint and with application/json header ",
        () async {
      when(mockHttpClient.get(any as Uri, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      dataSource.getConcreteNumberTrivia(tNumber);
      final url = Uri.parse("http://numbersapi.com/$tNumber");
      verify(mockHttpClient.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ));
    });
  });
}
