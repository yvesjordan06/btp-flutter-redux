import 'package:hive/hive.dart';

import 'index.dart';

Box box = Hive.box('app');

class AppState {
  final int counter;
  final bool isFirstTime;
  final AnnonceState annonceState;
  final AuthenticationState authenticationState;

  bool get showSplashScreen => isFirstTime;

  AppState({this.annonceState, this.counter, this.authenticationState})
      : isFirstTime = false;

  AppState.initialState()
      : counter = box.get('counter') ?? 0,
        annonceState = AnnonceState.initialState(),
        authenticationState = AuthenticationState.initialState(),
        isFirstTime = true;

  AppState.fromJson(Map<String, dynamic> json)
      : counter = json['id'],
        annonceState = AnnonceState.fromJson(json['annonceState']),
        authenticationState =
            AuthenticationState.fromJson(json['authenticationState']),
        isFirstTime = json['isFirstTime'];

  Map<String, dynamic> get toJson {
    return {
      'counter': counter,
      'annonceState': annonceState.toJson,
      'isFirstTime': isFirstTime,
      'authenticationState': authenticationState,
    };
  }
}
