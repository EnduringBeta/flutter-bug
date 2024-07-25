import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';

/// flutter_intro testing
class IntroTestRoute extends StatefulWidget {
  const IntroTestRoute({super.key});

  static const String routeName = '/test';

  static const String title = "Custom Overlay Problem?";

  @override
  IntroTestRouteState createState() => IntroTestRouteState();
}

class IntroTestRouteState extends State<IntroTestRoute> {
  // region Consts, properties, variables

  static const String introGroup = 'Test Intro';
  static const String intro1Text = "For each category, consider how fulfilled "
      "you feel or how well you're embodying that trait. 🤔";
  static const String intro2Text = '0 means very unfulfilled 😞\r\n'
      '10 means amazingly, totally fulfilled 😄';
  //static const String intro3Text =
  //    '✨ These prompts will help spark your reflection for each category!';

  static const String guideIntroButtonKeyPrefix = 'Intro button';
  static const String guideIntroDefaultButtonText = 'Next';
  static const String guideIntroLastButtonText = 'Done';

  static const double _introOverlayPadding = 16;
  static const Color _introColor = Colors.white;
  static const TextStyle _introTextStyle =
      TextStyle(color: _introColor, fontSize: 16);

  // DELAY TOGGLES HERE
  static const bool shouldDelay = false;
  static const Duration introGuideDelay = Duration(seconds: 1);

  // CUSTOM OVERLAY TOGGLES HERE
  // If this is true, the custom overlay will be used, and only the first intro
  // step will be shown. FIXME
  static const bool useCustomOverlay = true;

  // endregion Consts, properties, variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: _buildCategories()),
    );
  }

  void _onWidgetLoad(BuildContext context, String group) {
    final Intro intro = Intro.of(context);
    if (shouldDelay) {
      Future.delayed(
          introGuideDelay, () => intro.start(group: group, reset: true));
    } else {
      intro.start(group: group, reset: true);
    }
  }

  // region Build

  /// Build category widgets.
  List<Widget> _buildCategories() {
    return [
      Column(
        children: [
          const Text("Description 1"),
          IntroStepBuilder(
            order: 1,
            text: intro1Text,
            group: introGroup,
            onWidgetLoad: () => _onWidgetLoad(context, introGroup),
            overlayBuilder: useCustomOverlay
                ? (StepWidgetParams params) =>
                    _buildIntroOverlay(params, intro1Text, 1)
                : null,
            builder: (_, Key key) => Slider(
              key: key,
              value: 1,
              onChanged: (double newValue) {},
              min: 0,
              max: 10,
              divisions: 10,
            ),
          ),
        ],
      ),
      Column(
        children: [
          const Text("Description 2"),
          IntroStepBuilder(
            order: 2,
            text: intro2Text,
            group: introGroup,
            overlayBuilder: useCustomOverlay
                ? (StepWidgetParams params) =>
                    _buildIntroOverlay(params, intro2Text, 2)
                : null,
            builder: (_, Key key) => Slider(
              key: key,
              value: 2,
              onChanged: (double newValue) {},
              min: 0,
              max: 10,
              divisions: 10,
            ),
          ),
        ],
      ),
      Column(
        children: [
          const Text("Description 3"),
          Slider(
            value: 3,
            onChanged: (double newValue) {},
            min: 0,
            max: 10,
            divisions: 10,
          ),
        ],
      ),
    ];
  }

  /// Return [Widget] for intro highlight, [text], and button. This is used for
  /// larger font size than default `flutter_intro`.
  Widget _buildIntroOverlay(
      StepWidgetParams params, String text, int stepOrder) {
    final bool isLastStep = params.onNext == null;
    return Container(
      padding: const EdgeInsets.all(_introOverlayPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: _introTextStyle),
          Padding(
            padding: const EdgeInsets.only(top: _introOverlayPadding),
            child: OutlinedButton(
              key: Key('$guideIntroButtonKeyPrefix ${params.group} $stepOrder'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _introColor,
                side: const BorderSide(color: _introColor),
              ),
              onPressed: isLastStep ? params.onFinish : params.onNext,
              child: Text(
                isLastStep
                    ? guideIntroLastButtonText
                    : guideIntroDefaultButtonText,
                style: _introTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

// endregion Build
}

MaterialPageRoute buildIntroTestRoute() {
  return MaterialPageRoute<void>(
    builder: (context) => const IntroTestRoute(),
    settings: const RouteSettings(name: IntroTestRoute.routeName),
  );
}
