import 'package:dio/dio.dart';

import '../models/index.dart';

extension ApiResponses on Response {
  // Annonces

  List<AnnonceModel> get annoncesListData {
    return this.data.map((json) => AnnonceModel.fromJson(json));
  }

  AnnonceModel get annonceData {
    return AnnonceModel.fromJson(this.data);
  }

  // User Responses

  UserModel get userData {
    return UserModel.fromJson(this.data);
  }

  // Actu Responses

  List<ActuModel> get actusListData {
    return this.data.map((json) => AnnonceModel.fromJson(json));
  }

  ActuModel get actuData {
    return ActuModel.fromJson(this.data);
  }

  // Metier Responses

  List<MetierModel> get metierListData {
    return this.data.map((json) => MetierModel.fromJson(json));
  }

  MetierModel get metierData {
    return MetierModel.fromJson(this.data);
  }

  // Chat Responses

  List<ChatModel> get chatListData {
    return this.data.map((json) => ChatModel.fromJson(json));
  }

  ChatModel get chatData {
    return ChatModel.fromJson(this.data);
  }

  // Messages Responses

  MessageModel get messageData {
    return MessageModel.fromJson(this.data);
  }

  NewMessageModel get newMessageData {
    return NewMessageModel.fromJson(this.data);
  }

  // Token Response

  String get tokenData {
    //print('From api ${this.data.runtimeType}');
    return this.data['value'];
  }
}
