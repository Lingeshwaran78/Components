library component;

import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Components {
  static final Components _components = Components._internal();

  factory Components() {
    return _components;
  }
  static bool _showLog = true;

  Components._internal();
  // Method to toggle logging
  static void showLogging(bool showLog) {
    _showLog = showLog;
  }

  ///it can print the longer data
  static void logger(dynamic text) {
    if (_showLog == true) dev.log(text.toString());
  }

  ///it can print the error and its stacktrace used for try catch
  static void loggerStackTrace(dynamic e, StackTrace stackTrace) {
    if (_showLog == true) dev.log('Error: $e ::: stackTrace: $stackTrace');
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  ///it has outlined input border
  static InputDecoration textFieldDecoration({
    String? hintText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
    );
  }

  ///simple sized box with only height
  static SizedBox sizedBoxHeight(double height) {
    return SizedBox(height: height);
  }

  ///simple sized box with only width
  static SizedBox sizedBoxWidth(double width) {
    return SizedBox(width: width);
  }

  ///need url_launcher package
  static Future<bool> urlLauncher(String url) async {
    Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        logger("can launch");
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e, stackTrace) {
      logger("could not launch url :: $url");
      loggerStackTrace(e, stackTrace);
    }
    return false;
  }

  static String validString(String? strText) {
    try {
      if (strText == null) {
        return "";
      } else if (strText.trim().isEmpty) {
        return "";
      } else {
        return strText.trim();
      }
    } catch (e) {
      return "";
    }
  }

  static showToast(
      {BuildContext? context,
      String? strMsg,
      Color toastBgColor = Colors.black,
      Color textColor = Colors.white,
      Toast toastLength = Toast.LENGTH_SHORT}) {
    try {
      _showToastMsg(
          strMsg: validString(strMsg),
          fontSize: 13.00,
          bgColor: toastBgColor,
          textColor: textColor,
          toastLength: toastLength);
    } catch (e, stacktrace) {
      loggerStackTrace(e, stacktrace);
    }
  }

  ///custom toast message visible to user
  static void _showToastMsg(
      {required String strMsg,
      required double fontSize,
      required Color bgColor,
      required Color textColor,
      required Toast toastLength}) {
    try {
      Fluttertoast.showToast(
        msg: strMsg,
        toastLength: toastLength,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: fontSize,
      );
    } catch (e, stacktrace) {
      loggerStackTrace(e, stacktrace);
    }
  }

  /// to add loader for whole screen
  static Widget showLoader(
      {required bool isLoading,
      required context,
      double sigmaX = 2.0,
      double sigmaY = 2.0}) {
    return Visibility(
      visible: isLoading,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
          height: Components.screenHeight(context),
          width: Components.screenWidth(context),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  /// simple exit dialog used for leaving from app
  showExitDialog(context, {String title = ""}) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: const Text("Do you Want to Leave the App ? "),
        actions: [
          FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No")),
          FilledButton(onPressed: () => exit(0), child: const Text("Yes")),
        ],
      ),
    );
  }

  /// it will give the flag of true if the given list is either null or empty
  static bool isNullOrEmptyList(List? list) {
    if (list == null || list.isEmpty || list == []) {
      return true;
    } else {
      return false;
    }
  }

  /// it will give the flag of true if the given string is either null or empty
  static bool isNullOrEmptyString(String? text) {
    if (text == null || text.isEmpty || text.trim() == "") {
      return true;
    } else {
      return false;
    }
  }

  /// for conversion of base64String to Uint8List which is used to display image in Image.memory
  static Uint8List convertBase64ToImage(String base64String) {
    return const Base64Decoder().convert(base64String.split(',').last);
  }

  ///here is how to use the converted string to an image
  //Image.memory(
  //  convertBase64Image(base64String),
  //  gaplessPlayback: true,
  //)
}

/// animated button with shrinking behaviour
class ShrinkingButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onTap;
  final Color buttonColor;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;
  final double buttonHeight;
  final double borderWidth;
  final Widget? child;
  final double borderRadiusCircular;
  final double horizontalPaddingForText;
  final double verticalPaddingForText;
  final Color buttonBorderColor;
  final bool needBoxShadow;
  final bool? progress;
  final Color? progressColor;

  const ShrinkingButton({
    super.key,
    this.buttonColor = const Color(0xFF37003C),
    this.text,
    this.textColor = Colors.white,
    this.textSize = 14,
    this.fontWeight = FontWeight.w700,
    this.buttonHeight = 45,
    this.borderWidth = 0.1,
    this.child,
    this.borderRadiusCircular = 8,
    this.horizontalPaddingForText = 0,
    this.verticalPaddingForText = 0,
    this.buttonBorderColor = Colors.transparent,
    this.onTap,
    this.needBoxShadow = false,
    this.progress = false,
    this.progressColor = const Color(0xFF000000),
  });

  @override
  State<ShrinkingButton> createState() => _ShrinkingButtonState();
}

class _ShrinkingButtonState extends State<ShrinkingButton>
    with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 100;

  double _scaleTransformValue = 1;

  // needed for the "click" tap effect
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() => _scaleTransformValue = 1 - animationController.value);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () => animationController.reverse(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        _shrinkButtonSize();
        _restoreButtonSize();
      },
      onTapDown: (_) => _shrinkButtonSize(),
      onTapCancel: _restoreButtonSize,
      child: Transform.scale(
        scale: _scaleTransformValue,
        child: Container(
          height: widget.buttonHeight,
          decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(widget.borderRadiusCircular),
            border: Border.all(
                width: widget.borderWidth, color: widget.buttonBorderColor),
            boxShadow: widget.needBoxShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4.0,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: widget.progress! == true
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        color: widget.progressColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                )
              : Center(
                  child: widget.child ??
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.horizontalPaddingForText,
                          vertical: widget.verticalPaddingForText,
                        ),
                        child: Text(
                          widget.text ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: widget.textColor,
                            fontSize: widget.textSize,
                            fontWeight: widget.fontWeight,
                          ),
                        ),
                      ),
                ),
        ),
      ),
    );
  }
}
