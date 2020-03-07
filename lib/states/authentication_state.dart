import '../models/index.dart';

class AuthenticationState {
  final UserModel user;

  // Status States
  final bool connecting;
  final bool creating;
  final bool editing;
  final bool changingPicture;

  //Error States
  final String createError;
  final String loginError;
  final String editError;
  final String pictureError;

  AuthenticationState({
    this.user,
    this.connecting,
    this.creating,
    this.editing,
    this.changingPicture,
    this.createError,
    this.loginError,
    this.editError,
    this.pictureError,
  });

  AuthenticationState.initialState()
      : user = null,
        connecting = false,
        creating = false,
        changingPicture = false,
        editing = false,
        createError = '',
        loginError = '',
        editError = '',
        pictureError = '';

  AuthenticationState.fromJson(Map<String, dynamic> json)
      : user = UserModel.fromJson(json['user']),
        connecting = false,
        creating = false,
        changingPicture = false,
        editing = false,
        createError = '',
        loginError = '',
        editError = '',
        pictureError = '';

  Map<String, dynamic> get toJson {
    return {
      'user': user.toJson,
    };
  }

  /// This method get the query result list
  bool get isAuthenticated {
    return !(user == null);
  }
}
