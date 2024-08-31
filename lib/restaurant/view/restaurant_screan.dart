import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/dio/dio.dart';
import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/provider/restaurant_provider.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScrean extends ConsumerWidget {
  const RestaurantScrean({super.key});

//future 로 왜 반환하는가> async로 함수를 선언했기 떄문
//왜 async로 선언을 했냐 Http로 요청을 받을거기 떄문
  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);
    final resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();
    return resp.cursonPaginationData;
  }

  @override
  Widget build(BuildContext context, ref) {
    final restaurantRepositoryProviderData = ref.watch(restaruantProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: restaurantRepositoryProviderData.length,
        itemBuilder: (context, index) {
          final pItem = restaurantRepositoryProviderData[index];
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RestaurantDetailScreen(
                    id: pItem.id,
                  ),
                ));
              },
              child: RestaurantCard.fromModel(model: pItem));
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.0);
        },
      ),
    );
  }
}
