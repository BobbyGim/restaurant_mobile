import 'dart:io';

import 'package:dio/dio.dart';

final emulatorIp = 'http://10.0.2.2:3000'; // For Android Emulator
final simulatorIp = 'http://127.0.0.1:3000'; // For iOS Simulator

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

final dio = Dio();

class DataUtils {
  static String pathToUrl(String path) {
    return '$ip$path';
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((path) => pathToUrl(path)).toList();
  }
}
