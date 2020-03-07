import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import 'api_responses.dart';

String _token = Hive.box('app').get('token') + 'e';

const Map<String, String> _cred = {
  'login': 'castel@gmail.com',
  'password': 'testtest'
};

Dio dio = Dio(
  new BaseOptions(
    //baseUrl: "https://jsonplaceholder.typicode.com",
    baseUrl: "https://btp-partnership.herokuapp.com",
    connectTimeout: 10000,
    headers: {'X-Auth-Token': _token},
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onRequest: (request) {
        print("""DIO REQUEST ${request.method}  ON URL ${request.uri}""");

        return request..headers['X-Auth-Token'] = _token;
      },
      onResponse: (response) {
        print(
            "DIO RESPONSE ${response.statusCode} ${response.request.method}  on url ${response.request.path}");

        return response;
      },
      onError: (error) async {
        print(
            "DIO ERROR ${error.response?.statusCode} FOR ${error.request.method}  on url ${error.request.path}");

        if (error.response?.statusCode == 401) {
          print("Token Invalided");
          RequestOptions options = error.response.request;

          if (_token != options.headers['X-Auth-Token']) {
            options.headers['X-Auth-Token'] = _token;
            return dio.request(options.path, options: options);
          }

          dio.lock();
          dio.interceptors.errorLock.lock();
          print("DIO REQUESTING NEW TOKEN ...");
          Response tokenResponse =
              await Dio(dio.options).post('/auth-tokens', data: _cred);
          _token = tokenResponse.tokenData;
          Hive.box('app').put('token', _token);
          print("DIO RECIEVED NEW TOKEN $_token");
          dio.unlock();

          return dio.request(options.path, options: options);
        }

        return error;
      },
    ),
  );
