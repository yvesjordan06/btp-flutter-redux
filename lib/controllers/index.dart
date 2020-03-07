import '../states/index.dart';
import 'counter/index.dart';

export 'counter/index.dart';

AppState appReducer(AppState state, action) {
  return AppState(counter: counterReducer(state.counter, action));
}
