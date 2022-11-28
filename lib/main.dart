import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String bugName = "Screenshot Text Always Overflows?";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Screenshot Text Always Overflows?',
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
  final ScreenshotController screenshotController = ScreenshotController();

  int _counter = 0;

  void _screenshotShareAndCount() async {
    // TODOROSS
    Uint8List bytes = await screenshotController.captureFromWidget(
      Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 5.0),
            color: Colors.redAccent,
          ),
          child: const Text("This is an invisible widget")),
    );
    Share.shareXFiles([]);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _screenshotShareAndCount,
        tooltip: 'Screenshot',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
