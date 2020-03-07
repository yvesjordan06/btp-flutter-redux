class UserModel {
  final int id;

  bool get isAnnonceur => true;
  bool get isEntreprise => isAnnonceur && false;
  bool get isTravailleur => !isAnnonceur;

  UserModel({this.id});

  UserModel.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> get toJson {
    return {
      'id': id,
    };
  }
}
