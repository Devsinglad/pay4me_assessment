import 'package:flutter/material.dart';

class ResponsiveHelper {
  /// Device screen width
  final double screenWidth;

  /// Device screen height
  final double screenHeight;

  /// Device pixel ratio
  final double pixelRatio;

  /// Safe area top padding
  final double safeAreaTop;

  /// Safe area bottom padding
  final double safeAreaBottom;

  /// Safe area left padding
  final double safeAreaLeft;

  /// Safe area right padding
  final double safeAreaRight;

  /// Design reference width (based on iPhone 13 - 390x844)
  final double designWidth;

  /// Design reference height (based on iPhone 13 - 390x844)
  final double designHeight;

  /// Whether the device is in landscape mode
  final bool isLandscape;

  /// Device type
  final DeviceType deviceType;

  ResponsiveHelper._({
    required this.screenWidth,
    required this.screenHeight,
    required this.pixelRatio,
    required this.safeAreaTop,
    required this.safeAreaBottom,
    required this.safeAreaLeft,
    required this.safeAreaRight,
    required this.isLandscape,
    this.designWidth = 390,
    this.designHeight = 844,
  }) : deviceType = _getDeviceType(screenWidth, pixelRatio);

  /// Factory constructor to create a ResponsiveHelper instance from the BuildContext
  factory ResponsiveHelper.of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final padding = mediaQuery.padding;
    final orientation = mediaQuery.orientation;

    return ResponsiveHelper._(
      screenWidth: size.width,
      screenHeight: size.height,
      pixelRatio: mediaQuery.devicePixelRatio,
      safeAreaTop: padding.top,
      safeAreaBottom: padding.bottom,
      safeAreaLeft: padding.left,
      safeAreaRight: padding.right,
      isLandscape: orientation == Orientation.landscape,
    );
  }

  /// Determine the device type based on screen width and pixel ratio
  static DeviceType _getDeviceType(double width, double pixelRatio) {
    if (width >= 900) {
      return DeviceType.tablet;
    } else if (width >= 600) {
      return DeviceType.largePhone;
    } else {
      return DeviceType.phone;
    }
  }

  /// Scale a width value according to the screen size
  double scaleWidth(double width) {
    return width * (screenWidth / designWidth);
  }

  /// Scale a height value according to the screen size
  double scaleHeight(double height) {
    return height * (screenHeight / designHeight);
  }

  /// Scale a font size according to the screen size
  double scaleFontSize(double fontSize) {
    final scaleFactor = isLandscape
        ? (screenHeight / designWidth)
        : (screenWidth / designWidth);

    return fontSize * scaleFactor;
  }

  /// Scale both width and height values proportionally
  double scale(double size) {
    return (scaleWidth(size) + scaleHeight(size)) / 2;
  }

  /// Get scaled padding based on the reference design
  EdgeInsets scalePadding(double horizontal, double vertical) {
    return EdgeInsets.symmetric(
      horizontal: scaleWidth(horizontal),
      vertical: scaleHeight(vertical),
    );
  }

  /// Get horizontal spacing (width) based on percentage of screen width
  double getWidthPercentage(double percentage) {
    return screenWidth * (percentage / 100);
  }

  /// Get vertical spacing (height) based on percentage of screen height
  double getHeightPercentage(double percentage) {
    return screenHeight * (percentage / 100);
  }

  /// Generate responsive value based on screen size for different device types
  T responsiveValue<T>({
    required T defaultValue,
    T? tabletValue,
    T? largePhoneValue,
    T? landscapeValue,
  }) {
    /// First check if we're in landscape mode and have a specific value for it
    if (isLandscape && landscapeValue != null) {
      return landscapeValue;
    }

    switch (deviceType) {
      case DeviceType.tablet:
        return tabletValue ?? defaultValue;
      case DeviceType.largePhone:
        return largePhoneValue ?? defaultValue;
      case DeviceType.phone:
      return defaultValue;
    }
  }

  /// Check if the device has a large screen (tablet)
  bool get isTablet => deviceType == DeviceType.tablet;

  /// Check if the device is a phone
  bool get isPhone => deviceType == DeviceType.phone;

  /// Check if the device is a large phone
  bool get isLargePhone => deviceType == DeviceType.largePhone;

  /// Get the available screen height (excluding safe areas)
  double get availableScreenHeight => screenHeight - safeAreaTop - safeAreaBottom;

  /// Get the available screen width (excluding safe areas)
  double get availableScreenWidth => screenWidth - safeAreaLeft - safeAreaRight;
}

/// Enum representing different device types
enum DeviceType {
  phone,
  largePhone,
  tablet,
}
