import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RootRestorationScope(
      restorationId: "root",
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RestorationMixin {
  // int _counter = 0;

  // RestorableInt _counter = RestorableInt(0);
  RestorableDuration _duration = RestorableDuration();

  void _incrementCounter() {
    setState(() {
      // _counter.value++;
      _duration.value = Duration(microseconds: 500);
    });
  }

  @override
  void dispose() {
    // _counter.dispose();
    _duration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              // '${_counter.value}',
              "${_duration.value.inMicroseconds}",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  String get restorationId => "countertest";

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_duration, restorationId);
  }
}

class RestorableDuration extends RestorableValue<Duration> {
  @override
  Duration createDefaultValue() {
    return const Duration();
  }

  @override
  void didUpdateValue(Duration oldValue) {
    if (oldValue.inMicroseconds != value.inMicroseconds) {
      notifyListeners();
    }
  }

  @override
  Duration fromPrimitives(Object data) {
    return Duration(microseconds: data as int);
  }

  @override
  Object toPrimitives() {
    return value.inMicroseconds;
  }
}
