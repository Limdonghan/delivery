import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';

const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final ipAddress = 'MyAPI'; //갤럭시 IP

final ip = Platform.isAndroid ? ipAddress : '연결실패';
