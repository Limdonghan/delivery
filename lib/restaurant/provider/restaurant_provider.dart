/*
 * 캐시를 관리하는 모든 프로바이더들은
 * StateNotifier프로바이더로 작성 
 * -> 메소드들을 많이 생성해서 로직을 다 클래스 안에다 집어넣을 거기 때문에
 */

import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaruantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
        (ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;
  //기본적으로 상태가 아무것도 없는 상태로 생성
  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    paginate(); //RestaurantStateNotifier 생성되면 바로 함수 실행
  }

  paginate() async {
    final resp = await repository.paginate();

    state = resp.cursonPaginationData;
  }
}
