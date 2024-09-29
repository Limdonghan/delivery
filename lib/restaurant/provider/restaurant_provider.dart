import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final respository = ref.watch(restaurantRespositoryProvider);

    final notifier =
        RestaurantStateNotifier(restaurantRespository: respository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository restaurantRespository;

  RestaurantStateNotifier({
    required this.restaurantRespository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  paginate() async {
    final resp = await restaurantRespository.paginate();

    state = resp;
  }
}
