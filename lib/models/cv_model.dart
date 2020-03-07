class CVModel {
  final int id;

  CVModel({this.id});

  CVModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}
