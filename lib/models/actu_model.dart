class ActuModel {
  final int id;
  final String intitule;
  final String description;

  ActuModel({
    this.id,
    this.intitule,
    this.description,
  });

  ActuModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        intitule = json['intitule'],
        description = json['description'];

  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'intitule': intitule,
      'description': description,
    };
  }
}
