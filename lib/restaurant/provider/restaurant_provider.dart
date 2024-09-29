import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
  (ref) {
    final respository = ref.watch(restaurantRespositoryProvider);

    final notifier = RestaurantStateNotifier(respository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPagination> {
  final RestaurantRepository respository;

  RestaurantStateNotifier(
    this.respository,
  ) : super(CursorPagination(meta: meta, data: data)) {
    paginate();
  }

  paginate() async {
    final resp = await respository.paginate();

    state = resp.data;
  }
}
