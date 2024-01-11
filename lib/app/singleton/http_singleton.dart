import 'package:http/http.dart' as http;

class HttpSingleton {
  static final HttpSingleton _singleton = HttpSingleton._internal();

  http.Client _client;

  factory HttpSingleton() {
    return _singleton;
  }

  HttpSingleton._internal() : _client = http.Client();

  http.Client get client => _client;

  // You can add additional methods or configurations as needed

  void close() {
    _client.close();
  }
}
