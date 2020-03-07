import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hiro_test/api/index.dart';
import 'package:hiro_test/views/index.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';

import 'controllers/index.dart';
import 'models/index.dart';
import 'states/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox('app');
  ActuModel a = ActuModel(id: 2);
  print(a.toJson);
  final Store store = Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Store store;

  const MyApp({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
        ),
        home: Initial(),
      ),
    );
  }
}

class Initial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: OutlineButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            child: Text('Go to page')),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Store store = StoreProvider.of<AppState>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Hiro Redux'),
      ),
      body: Builder(builder: (context) {
        return Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              StoreConnector<AppState, int>(
                distinct: true,
                converter: (store) => store.state.counter,
                builder: (context, _counter) {
                  return Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
                onWillChange: (i, j) async {
                  print('changing in 5');
                  await Future.delayed(Duration(seconds: 5));
                  print('changing now');
                },
                onDidChange: (current) {
                  print("current $current");
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(current.toString())));
                },
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => store.dispatch(CounterReset()),
            child: Icon(Icons.refresh),
            mini: true,
          ),
          FloatingActionButton(
            heroTag: 'e',
            onPressed: () {
              doRequest();
              return store.dispatch(CounterIncrement());
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'x',
            onPressed: () => store.dispatch(CounterDecrement()),
            child: Icon(Icons.remove),
            mini: true,
          ),
          FloatingActionButton(
            heroTag: 'xx',
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ImagePicker()));
            },
            child: Icon(Icons.photo_camera),
            mini: true,
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
