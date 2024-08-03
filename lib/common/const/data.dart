import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: constant_identifier_names
const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
// ignore: constant_identifier_names
const REFRESS_TOKEN_KEY = 'REFRESS_TOKEN';

const storage = FlutterSecureStorage();

// ignore: prefer_const_declarations
final ipAddress = '192.168.1.6:3000'; //갤럭시 IP

final ip = Platform.isAndroid ? ipAddress : '연결실패';
