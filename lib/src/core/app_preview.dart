import 'package:flutter/foundation.dart';

class AppPreview {
  const AppPreview._();

  static const String _previewFlag = String.fromEnvironment(
    'APP_PREVIEW',
    defaultValue: 'false',
  );

  static bool get enabled {
    if (kReleaseMode || kIsWeb || _previewFlag.toLowerCase() != 'true') {
      return false;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}
