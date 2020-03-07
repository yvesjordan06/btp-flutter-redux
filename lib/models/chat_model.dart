class ChatModel {
  final int id;

  ChatModel({this.id});

  ChatModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}
