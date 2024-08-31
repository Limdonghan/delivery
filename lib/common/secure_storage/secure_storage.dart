import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//FlutterSecureStorage이 한 번  provider이 생성이 될 때 반환이 되면 하나의 값을 갖고 프로젝트 안에서 돌려서 사용할 것이다.
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => FlutterSecureStorage(),
);


/**
 * #FlutterSecureStorage#
 * Flutter 애플리케이션에서 안전하게 데이터를 저장하기 위한 플러그인
 * 키-값 쌍으로 데이터를 안전하게 저장
 * OS의 Keychain과 Android의 Keystore 시스템을 내부적으로 사용하여 데이터를 암호화
 */