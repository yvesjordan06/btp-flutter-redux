import 'package:hive/hive.dart';
import 'package:redux/redux.dart';

import 'counter_actions.dart';

Box box = Hive.box('app');

int _incrementReducer(int state, CounterIncrement action) {
  print('activated $state');
  box.put('counter', ++state);
  return state;
}

int _decrementReducer(int state, CounterDecrement action) {
  print('also activated');
  box.put('counter', --state);
  return state;
}

int _counterResetReducer(int state, CounterReset action) {
  return 0;
}

final Reducer<int> counterReducer = combineReducers<int>([
  new TypedReducer(_incrementReducer),
  new TypedReducer(_decrementReducer),
  new TypedReducer(_counterResetReducer),
]);
