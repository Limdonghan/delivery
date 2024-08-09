import 'package:delivery/common/const/data.dart';

//데이터 모델링 URL 주소
class DataUtils {
  static pathToUrl(String value) {
    return 'http://$ip$value';
  }
}
