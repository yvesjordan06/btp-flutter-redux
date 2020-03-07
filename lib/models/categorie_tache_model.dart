class CategorieTacheModel {
  final int id;

  CategorieTacheModel({this.id});

  CategorieTacheModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}
