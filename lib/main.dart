import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String bugName = "Cupertino Slider Hit Test Bug";

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
  static const double sliderValue1 = 1;
  static const double sliderValue2 = 5;
  static const double sliderValue3 = 9;

  List<double> sliderValues = <double>[
    sliderValue1,
    sliderValue2,
    sliderValue3
  ];

  void _onSliceChange(int sliderNum, double newValue) {
    setState(() {
      sliderValues[sliderNum] = newValue;
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
            const Text('Slider 1'),
            Slider.adaptive(
              key: const Key('Slider 1'),
              value: sliderValues[0],
              onChanged: (newValue) => _onSliceChange(0, newValue),
              divisions: 10,
              min: 0,
              max: 10,
            ),
            const Text('Slider 2'),
            Slider.adaptive(
              key: const Key('Slider 2'),
              value: sliderValues[1],
              onChanged: (newValue) => _onSliceChange(1, newValue),
              divisions: 10,
              min: 0,
              max: 10,
            ),
            const Text('Slider 3'),
            Slider.adaptive(
              key: const Key('Slider 3'),
              value: sliderValues[2],
              onChanged: (newValue) => _onSliceChange(2, newValue),
              divisions: 10,
              min: 0,
              max: 10,
            ),
          ],
        ),
      ),
    );
  }
}
