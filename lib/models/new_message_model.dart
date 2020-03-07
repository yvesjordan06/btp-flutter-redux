import 'package:hiro_test/models/index.dart';

class NewMessageModel {
  final int id;
  final int chatID;
  final String text;
  final String image;
  final UserModel sender;
  final DateTime datePost;

  bool get hasImage => image != null;

  NewMessageModel(
      {this.chatID,
      this.text,
      this.sender,
      this.datePost,
      this.id,
      this.image});

  NewMessageModel.fromJson(Map<String, dynamic> json)
      : id = json['message']['id'],
        image = json['message']['image'],
        chatID = json['chat_id'],
        text = json['message']['text'],
        sender = json['message']['annonceur'] != null
            ? UserModel(id: json['message']['annonceur']['id'])
            : UserModel(id: json['message']['travailleur']['id']),
        datePost = DateTime.parse(json['message']['date_post']);

  NewMessageModel copyWith(
      {int chatID,
      int text,
      UserModel sender,
      DateTime datePost,
      int id,
      String image}) {
    return NewMessageModel(
        id: id ?? this.id,
        chatID: chatID ?? this.chatID,
        text: text ?? this.text,
        sender: sender ?? this.sender,
        datePost: datePost ?? this.datePost,
        image: image ?? this.image);
  }

  Map<String, dynamic> get toJson {
    return {
      'type': text == null ? 'image' : 'text',
      'id': id,
      'chat_id': chatID,
      if (text != null) 'text': text,
      'id_travailleur': sender.isTravailleur ? sender.id : null,
      'id_annonceur': sender.isAnnonceur ? sender.id : null,
      'date_post': datePost?.toIso8601String()
    };
  }
}
