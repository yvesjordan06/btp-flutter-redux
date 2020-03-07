class MetierModel {
  final int id;

  MetierModel({this.id});

  MetierModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}
