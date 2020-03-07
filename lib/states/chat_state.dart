import 'package:hiro_test/models/chat_model.dart';

class ChatState {
  final List<ChatModel> chats;

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

  ChatState({
    this.chats,
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

  ChatState.initialState()
      : chats = List.unmodifiable([]),
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

  ChatState.fromJson(Map<String, dynamic> json)
      : chats = (json['chats'] as List<Map<String, dynamic>>)
            .map((f) => ChatModel.fromJson(f)),
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
    return {'chats': List.unmodifiable(chats.map((f) => f.toJson))};
  }

  /// This method get the query result list
  List<ChatModel> get queryResult {
    String query = searchQuery.toLowerCase();

    if (searchQuery == null || searchQuery.isEmpty) {
      return chats;
    }

    return chats.where((test) {
      if (test.id.toString().toLowerCase().contains(query) ||
          test.id.toString().toLowerCase().contains(query)) {
        return true;
      }
      return false;
    });
  }
}
