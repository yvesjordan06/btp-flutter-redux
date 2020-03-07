import 'dart:async';
import 'dart:convert';

import 'package:dart_mercure/dart_mercure.dart';
import 'package:dio/dio.dart';
import 'package:hiro_test/api/main.dart';

import '../models/index.dart';
import 'api_responses.dart';

abstract class MessageApi {
  //static final Dio _dio = dio;
  static const baseUrl = "/chats/message";
  static bool streamStarted = false;

  static StreamController<NewMessageModel> _newMessageStream;

  static _path(String url) => baseUrl + url;

  static Future<List<ChatModel>> send() async {
    Response response = await dio.get(_path(''));

    return response.chatListData;
  }

  static Stream<NewMessageModel> getStream() {
    if (MessageApi.streamStarted) stopStream();
    MessageApi.streamStarted = true;
    _newMessageStream = StreamController<NewMessageModel>();
    _newMessageStream.sink;
    String hubUrl = "https://btp-partnership-merure.herokuapp.com/hub";
    String topic = "new-message";

    Mercure mercure = Mercure(
        token:
            'G1meHgz9daQp0mDoJ2xQanOWUajA1lERCDPAmBP2amnhaRcmiPnOm9vKBJ7gdjQFfY0=',
        hub_url: hubUrl);
    print('Mercure');

    mercure.subscribeTopic(
        topic: topic,
        onData: (Event event) {
          /*print('Mercure event');*/
          Map<String, dynamic> data = json.decode(event.data);
          _newMessageStream.add(NewMessageModel.fromJson(data));
        });

    return _newMessageStream.stream;
  }

  static void stopStream() {
    MessageApi.streamStarted = false;
    _newMessageStream.close();
  }

  static Future<MessageModel> sendMessage(NewMessageModel message) async {
    String path = _path('/${message.chatID}');
    String imagePath = _path('/image/upload/${message.chatID}');
    Response response = await dio.post(path, data: message.toJson);
    int newID = json.decode(response.data)['insert_id'];

    if (message.hasImage) {
      String imagePath = _path('/image/upload/$newID');
      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          message.image,
        ),
      });
      await dio.post(imagePath, data: data);
    }

    return MessageModel.fromNewMessage(message.copyWith(id: newID));
  }
}
