import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/provider/restaurant_provider.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScrean extends ConsumerWidget {
  const RestaurantScrean({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // restProvData = restaurantProviderData
    final restProvData = ref.watch(restaurantProvider);

    if (restProvData is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (restProvData is CursorPaginationError) {
      return Center(
        child: Text(restProvData.errMessage),
      );
    }

    // cp = CursorPagination의 약자
    final cp = restProvData as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: cp.data.length,
        itemBuilder: (context, index) {
          final pItem = cp.data[index];
          //factory construcor를 사용한 데이터 모델링
          //final pItem = RestaurantModel.fromJson(item);
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailScreen(
                      id: pItem.id,
                    ),
                  ),
                );
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
