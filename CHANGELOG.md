# Changelog

## [0.0.1] - 2024-07-14

### Added
- **Components**
    - Singleton pattern implemented for the `Components` class.
    - Method to toggle logging (`showLogging`).
    - Method to log messages (`logger`).
    - Method to log errors with stack trace (`loggerStackTrace`).
    - Methods to get screen height and width (`screenHeight`, `screenWidth`).
    - Method for input decoration with outlined border (`textFieldDecoration`).
    - Methods to create simple sized boxes (`sizedBoxHeight`, `sizedBoxWidth`).
    - Method to launch URLs using `url_launcher` (`urlLauncher`).
    - Method to validate and clean strings (`validString`).
    - Method to show toast messages using `fluttertoast` (`showToast`).
    - Method to show a full-screen loader (`showLoader`).
    - Method to show an exit dialog (`showExitDialog`).
    - Method to check if a list is null or empty (`isNullOrEmptyList`).
    - Method to check if a string is null or empty (`isNullOrEmptyString`).
    - Method to convert base64 strings to `Uint8List` (`convertBase64ToImage`).

- **ShrinkingButton**
    - Customizable button with a shrinking animation effect on tap.
    - Various customization options for button appearance and behavior, including text, colors, size, padding, and shadow.
    - Optional progress indicator within the button.
