# Components Package

A Flutter package that provides a variety of utility components and a customizable button with a shrinking animation effect.

## Features

- Utility methods for logging, screen size calculations, input decorations, URL launching, and more.
- A customizable `ShrinkingButton` widget with various styling options and a shrinking animation effect on tap.

## Installation

Add this package to your project's `pubspec.yaml` file:

```yaml
dependencies:
  components: ^0.0.1
```
then run 

flutter pub get

## Usage
```dart
import 'package:components/components.dart';

void main() {
  Components.showLogging(true);

  Components.logger('This is a log message');
  Components.loggerStackTrace('Error message', StackTrace.current);

  double height = Components.screenHeight(context);
  double width = Components.screenWidth(context);

  InputDecoration decoration =
  Components.textFieldDecoration(hintText: 'Enter text');

  SizedBox boxHeight = Components.sizedBoxHeight(10.0);
  SizedBox boxWidth = Components.sizedBoxWidth(10.0);

  Future<bool> launched = Components.urlLauncher('https://www.example.com');

  String cleanedString = Components.validString('  Some text  ');

  Components.showToast(
    context: context,
    strMsg: 'This is a toast message',
    toastBgColor: Colors.black,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );

  Widget loader = Components.showLoader(isLoading: true, context: context);

  Components().showExitDialog(context, title: 'Exit');

  bool isListEmpty = Components.isNullOrEmptyList([]);
  bool isStringEmpty = Components.isNullOrEmptyString('   ');

  Uint8List imageBytes =
  Components.convertBase64ToImage('data:image/png;base64,iVBORw0KGgo...');
}
```

Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.
