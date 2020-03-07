import '../models/index.dart';

class AnnonceState {
  final List<AnnonceModel> annonces;

  // Status States
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

  AnnonceState({
    this.annonces,
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

  AnnonceState.initialState()
      : annonces = List.unmodifiable([]),
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

  AnnonceState.fromJson(Map<String, dynamic> json)
      : annonces = (json['annonces'] as List<Map<String, dynamic>>)
            .map((f) => AnnonceModel.fromJson(f)),
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
      'annonces': List.unmodifiable(annonces.map((f) => f.toJson)),
    };
  }

  /// This method get the query result list
  List<AnnonceModel> get queryResult {
    String query = searchQuery.toLowerCase();
    if (searchQuery == null || searchQuery.isEmpty) {
      return annonces;
    }

    return annonces.where((test) {
      if (test.intitule.toLowerCase().contains(query) ||
          test.description.toLowerCase().contains(query)) {
        return true;
      }
      return false;
    });
  }
}
