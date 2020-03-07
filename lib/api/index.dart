import 'package:hiro_test/api/test_api.dart';
import 'package:hiro_test/models/index.dart';
import 'package:hiro_test/models/new_message_model.dart';

export 'api_responses.dart';
export 'main.dart';

void doRequest() async {
  if (!MessageApi.streamStarted) {
    print('Message Stream BOOTING ...');
    Stream<NewMessageModel> stream = MessageApi.getStream();
    stream.listen((data) {
      print("Mercure data ${data.toJson}");
    });
  }

  MessageModel response = await MessageApi.sendMessage(
      new NewMessageModel(chatID: 31, text: 'Hello', sender: UserModel(id: 4)));
  print("Response Data ${response.toJson}");
}
