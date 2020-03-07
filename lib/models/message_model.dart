import 'package:hiro_test/models/index.dart';

class MessageModel {
  final int id;
  final String text;
  final DateTime datePost;
  final UserModel travailleur;
  final UserModel annonceur;
  final String image;

  MessageModel(
      {this.id,
      this.text,
      this.datePost,
      this.travailleur,
      this.annonceur,
      this.image});

  MessageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        image = json['image'],
        datePost = DateTime.tryParse(json['date_post']),
        travailleur = json['travailleur'] != null
            ? UserModel.fromJson(json['travailleur'])
            : null,
        annonceur = json['annonceur'] != null
            ? UserModel.fromJson(json['annonceur'])
            : null;

  MessageModel.fromNewMessage(NewMessageModel newMessage)
      : id = newMessage.id,
        text = newMessage.text,
        image = newMessage.image,
        datePost = newMessage.datePost ?? DateTime.now().toLocal(),
        travailleur =
            newMessage.sender.isTravailleur ? newMessage.sender : null,
        annonceur = newMessage.sender.isAnnonceur ? newMessage.sender : null;

  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'text': text,
      'image': image,
      'date_post': datePost?.toIso8601String(),
      'travailleur': travailleur?.toJson,
      'annonceur': annonceur?.toJson
    };
  }

  MessageModel copyWith(
      {int id,
      String text,
      DateTime datePost,
      UserModel travailleur,
      UserModel annonceur,
      String image}) {
    return MessageModel(
        id: id ?? this.id,
        text: text ?? this.text,
        datePost: datePost ?? this.datePost,
        travailleur: travailleur ?? this.travailleur,
        annonceur: annonceur ?? this.annonceur,
        image: image ?? this.image);
  }
}
