import 'package:hiro_test/models/actu_model.dart';

class ActuState {
  final List<ActuModel> actus;

  //Status state
  final bool creating;
  final bool fetching;
  final bool editing;
  final bool deleting;
  final bool posting;
  final bool attributing;

  //Error States
  final String createError;
  final String fetchError;
  final String editError;
  final String deleteError;

  //Query State
  final String searchQuery;

  ActuState({
    this.actus,
    this.creating,
    this.fetching,
    this.editing,
    this.deleting,
    this.posting,
    this.attributing,
    this.createError,
    this.fetchError,
    this.editError,
    this.deleteError,
    this.searchQuery,
  });

  ActuState.initialState()
      : actus = List.unmodifiable([]),
        creating = false,
        fetching = false,
        deleting = false,
        editing = false,
        posting = false,
        attributing = false,
        createError = '',
        fetchError = '',
        editError = '',
        deleteError = '',
        searchQuery = '';

  ActuState.fromJson(Map<String, dynamic> json)
      : actus = (json['actus'] as List<Map<String, dynamic>>)
            .map((f) => ActuModel.fromJson(f)),
        creating = false,
        fetching = false,
        deleting = false,
        editing = false,
        posting = false,
        attributing = false,
        createError = '',
        fetchError = '',
        editError = '',
        deleteError = '',
        searchQuery = '';

  Map<String, dynamic> get toJson {
    return {
      'actus': List.unmodifiable(actus.map((f) => f.toJson)),
    };
  }

  /// This method get the query result list
  List<ActuModel> get queryResult {
    String query = searchQuery.toLowerCase();

    if (searchQuery == null || searchQuery.isEmpty) {
      return actus;
    }

    return actus.where((test) {
      if (test.intitule.toLowerCase().contains(query) ||
          test.description.toLowerCase().contains(query)) {
        return true;
      }
      return false;
    });
  }
}
