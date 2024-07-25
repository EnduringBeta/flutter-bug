import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';

import 'intro_test_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String bugName = "Flutter Intro Bug";

  @override
  Widget build(BuildContext context) {
    return Intro(
      child: const MaterialApp(
        title: 'Flutter Bug/Issue',
        home: MyHomePage(title: bugName),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  static const String introGroup = 'unused intro group';

  static const bool shouldDelay = false;
  static const Duration introGuideDelay = Duration(seconds: 1);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onWidgetLoad(BuildContext context, String group) {
    final Intro intro = Intro.of(context);
    if (MyHomePage.shouldDelay) {
      Future.delayed(MyHomePage.introGuideDelay,
          () => intro.start(group: group, reset: true));
    } else {
      intro.start(group: group, reset: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IntroStepBuilder(
          order: 3,
          text: 'Use this to go to the bug test route.',
          group: MyHomePage.introGroup,
          builder: (_, Key key) => IconButton(
            key: key,
            icon: const Icon(Icons.refresh),
            onPressed: () => Navigator.of(context).push(buildIntroTestRoute()),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            IntroStepBuilder(
              order: 2,
              text: 'The number is here!',
              group: MyHomePage.introGroup,
              builder: (_, Key key) => Text(
                key: key,
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: IntroStepBuilder(
        order: 1,
        text: 'This is the FAB. Tap it to increase the counter!',
        group: MyHomePage.introGroup,
        // Don't start intro here; test other route
        //onWidgetLoad: () => _onWidgetLoad(context, MyHomePage.introGroup),
        builder: (_, Key key) => FloatingActionButton(
          key: key,
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
