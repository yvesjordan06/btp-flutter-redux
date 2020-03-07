import 'package:hiro_test/models/index.dart';
import 'package:hiro_test/models/tache_model.dart';

class PostuleModel {
  final UserModel user;
  final AnnonceModel annonce;
  final List<TachesModel> taches;

  PostuleModel(this.user, this.annonce, this.taches);

  Map<String, dynamic> get toJson {
    return {
      "id_travailleur": user.id,
      "id_annonceur": annonce.annonceur.id,
      "id_annonce": annonce.id,
      "ids_taches": taches.map((f) => f.id).toList()
    };
  }
}
