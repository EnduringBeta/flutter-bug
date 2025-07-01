import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bug/service.dart';
import 'package:flutter_bug/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*
  // This causes the app to crash on iOS because of missing
  // GoogleService-Info.plist files.
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'fake',
    appId: 'fake',
    messagingSenderId: 'fake',
    projectId: 'fake',
  ));
  */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String bugName = "Bug Name";

  static final HashMap<String, int> romans = HashMap.of({
    "I": 1,
    "II": 2,
    "III": 3,
    "IV": 4,
    "V": 5,
    "VI": 6,
    "VII": 7,
    "VIII": 8,
    "IX": 9,
    "X": 10,
    "XI": 11,
    "XII": 12,
    "XIII": 13,
    "XIV": 14,
    "XV": 15,
    "XVI": 16,
    "XVII": 17,
    "XVIII": 18,
    "XIX": 19,
    "XX": 20,
  });

  static final HashMap<int, String> inverseRomans = HashMap.of({
    1: "I",
    2: "II",
    3: "III",
    4: "IV",
    5: "V",
    6: "VI",
    7: "VII",
    8: "VIII",
    9: "IX",
    10: "X",
    11: "XI",
    12: "XII",
    13: "XIII",
    14: "XIV",
    15: "XV",
    16: "XVI",
    17: "XVII",
    18: "XVIII",
    19: "XIX",
    20: "XX",
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Bug/Issue',
      home: MyHomePage(title: bugName),
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
  //int _counter = 0;

  String arg1 = 'VII+X';

  final List<User> users = <User>[];

  String result = '';

  Future<void> _onFabTap() async {
    // Get user list
    users.clear();
    final List<User> newUsers = await Service.getUsers();

    setState(() {
      users.clear();
      users.addAll(newUsers);
    });

    /*
    // Increment counter
    setState(() {
      _counter++;
    });
    */
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
          children: [
            TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Roman',
                ),
                style: const TextStyle(fontSize: 18),
                onChanged: (String arg) {
                  arg1 = arg.toUpperCase().replaceAll(' ', '');
                }),
            OutlinedButton(
                onPressed: _onCalc,
                child:
                    const Text('Calc Roman', style: TextStyle(fontSize: 24))),
            Text(result, style: const TextStyle(fontSize: 72)),
          ],
          //children: users.map((User u) => Text(u.name)).toList(),
          /*
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
          */
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabTap,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onCalc() {
    debugPrint('Roman to Decimal Kinda');

    if (arg1.contains('+')) {
      final List<String> args = arg1.split('+');
      MyApp.romans[args[0].replaceAll('+', '')];
      final int firstArg = MyApp.romans[args[0].replaceAll('+', '')]!;
      final int secondArg = MyApp.romans[args[1].replaceAll('+', '')]!;

      setState(() => result = MyApp.inverseRomans[firstArg + secondArg]!);
    } else if (arg1.contains('-')) {
      final List<String> args = arg1.split('-');
      final int firstArg = MyApp.romans[args[0].replaceAll('-', '')]!;
      final int secondArg = MyApp.romans[args[1].replaceAll('-', '')]!;

      setState(() => result = MyApp.inverseRomans[firstArg - secondArg]!);
    }
  }
}
