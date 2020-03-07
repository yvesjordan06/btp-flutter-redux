import 'package:hiro_test/models/index.dart';

class AnnonceModel {
  final int id;
  final String intitule;
  final String description;
  final UserModel annonceur;

  AnnonceModel({this.intitule, this.description, this.id, this.annonceur});

  AnnonceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        intitule = json['intitule'],
        description = json['description'],
        annonceur = UserModel.fromJson(json['annonceur']);

  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'intitule': intitule,
      'description': description,
      'annonceur': annonceur.toJson,
    };
  }
}
