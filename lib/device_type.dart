//
//  device_typeを指定
//
//  Created by 大内直 on 2024/08/24.
//
import 'package:flutter/material.dart';

// device指定
enum DeviceType {
    mobile,
    tablet,
    desktop,
}

DeviceType getDeviceType(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 430) {
        return DeviceType.mobile;
    } else if (screenWidth < 1024) {
        return DeviceType.tablet;
    } else {
        return DeviceType.desktop;
    }
}

double getDialogWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return screenWidth * 0.75;
      case DeviceType.tablet:
        return screenWidth * 0.56;
      case DeviceType.desktop:
        return screenWidth * 0.36;
    }
}

double getDialogHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return screenWidth * 0.85;
      case DeviceType.tablet:
        return screenWidth * 0.68;
      case DeviceType.desktop:
        return screenHeight * 0.64;
    }
}