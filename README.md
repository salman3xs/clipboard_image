# ClipboadImage

A Flutter plugin to copy and retrieve images from the clipboard.

## Features
- Retrieve an image from the clipboard

## Demo

- IOS

![Clipboard Image IOS Demo](assets/ios_demo.gif)
![Clipboard Image Android Demo](assets/android_demo.gif)

## Installation

Add `clipboad_image` to your `pubspec.yaml`:

```yaml
dependencies:
  clipboad_image:
    path: clipboad_image
```

Run:
```sh
flutter pub get
```

## Usage

### Import the package
```dart
import 'package:clipboad_image/clipboad_image.dart';
```

### Get an image from the clipboard
Use `await ClipboadImage.getImage()` to retrieve an image. If the result is `null`, the clipboard does not contain an image.

```dart
Uint8List? imageData = await ClipboadImage.getImage();
if (imageData != null) {
  print("Image retrieved from clipboard!");
} else {
  print("No image found in clipboard.");
}
```

### Copy an image from a browser (URL) to the clipboard
```dart
await ClipboadImage.copyImageFromUrl('https://example.com/sample-image.jpg');
print("Image copied to clipboard");
```

## Platform Support

| Platform | Support |
|----------|---------|
| Android  | ✅ Yes |
| iOS      | ✅ Yes |

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
