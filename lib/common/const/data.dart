import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: constant_identifier_names
const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
// ignore: constant_identifier_names
const REFRESH_TOKEN_KEY = 'REFRESS_TOKEN';

const storage = FlutterSecureStorage();

final ipAddress = 'My IP'; //갤럭시 IP

final ip = Platform.isAndroid ? ipAddress : '연결실패';
