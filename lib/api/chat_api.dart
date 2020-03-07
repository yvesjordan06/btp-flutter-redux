import 'package:dio/dio.dart';
import 'package:hiro_test/api/index.dart';
import 'package:hiro_test/models/chat_model.dart';
import 'package:hiro_test/models/index.dart';

abstract class ChatApi {
  static const baseUrl = "/chats";
  static _path(String url) => baseUrl + url;

  /// Appelle pour recuperer toute la liste des chats
  static Future<List<ChatModel>> getChats() async {
    Response response = await dio.get(_path(''));
    return response.chatListData;
  }

  /// Appelle pour recuperer toute la liste des chats pour un annonceur
  /// params {id} Id de l'annonceur
  static Future<List<ChatModel>> getChatsAnnonceur(int id) async {
    Response response = await dio.get(_path('/annonceur/$id'));
    return response.chatListData;
  }

  /// Appelle pour recuperer toute la liste des chats pour un travailleur
  /// params {id} Id du travailleur
  static Future<List<ChatModel>> getChatsTravailleur(int id) async {
    Response response = await dio.get(_path('/travailleur/$id'));
    return response.chatListData;
  }

  /// Appelle pour recuperer toute la liste des chats pour une annonce
  /// params {id} Id de l'annonce
  static Future<List<ChatModel>> getChatsAnnonce(int id) async {
    Response response = await dio.get(_path('/annonce/$id'));
    return response.chatListData;
  }

  /// Appelle pour creer un chat, Un chat est créer quand un utilisateur postule
  /// method POST
  /// params {body} Id de l'annonce
  static Future<List<ChatModel>> createChat(PostuleModel postule) async {
    Response response = await dio.post(_path('/creer'), data: postule.toJson);
    return response.chatListData;
  }
}
