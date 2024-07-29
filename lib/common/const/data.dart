import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY ='ACCESS_TOKEN';
const REFRESS_TOKEN_KEY ='REFRESS_TOKEN';


final storage = FlutterSecureStorage();


///final simulatorIp = '127.0.0.1:3000';
final ipAddress = '192.168.1.8:3000';  //갤럭시 IP
//final ipAddress2 = '192.168.1.5:3000';  //갤럭시 IP

final ip = Platform.isAndroid ? ipAddress : '연결실패';