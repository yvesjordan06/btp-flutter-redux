class TachesModel {
  final int id;

  TachesModel({this.id});

  TachesModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}
