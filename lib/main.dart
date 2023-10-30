import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'fake',
    appId: 'fake',
    messagingSenderId: 'fake',
    projectId: 'fake',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String bugName = "Icon Button Size";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bug/Issue',
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(title: bugName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          Flexible(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.mode_edit),
                  title: Text('Edit Object'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
          // It appears that Image width can only make it smaller than 32, and
          // iconSize can only make the container larger than 32.
          // The image is 100x100px.
          IconButton(
            icon: Image.asset(
              'assets/newsletter.png',
              width: 20,
            ),
            iconSize: 50,
            onPressed: () => debugPrint('Icon button tapped'),
          ),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
