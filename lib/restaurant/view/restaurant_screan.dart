import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/provider/restaurant_provider.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScrean extends ConsumerStatefulWidget {
  const RestaurantScrean({super.key});

  @override
  ConsumerState<RestaurantScrean> createState() => _RestaurantScreanState();
}

class _RestaurantScreanState extends ConsumerState<RestaurantScrean> {
  final ScrollController scrollerController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollerController.addListener(scrollerListener);
  }

  void scrollerListener() {
    // 현재 위치가
    // 최대 길이보다 조금 덜되는 위치까지 왔다면
    // 새로운 데이터를 추가 요청
    if (scrollerController.offset >
        scrollerController.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // restProvData = restaurantProviderData
    final restProvData = ref.watch(restaurantProvider);

    // 완전 처음 로딩
    if (restProvData is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (restProvData is CursorPaginationError) {
      return Center(
        child: Text(restProvData.errMessage),
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    // cp = CursorPagination의 약자
    final cp = restProvData as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: scrollerController,
        itemCount: cp.data.length,
        itemBuilder: (context, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Center(
                child: restProvData is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('더 이상 불러올 ~~'),
              ),
            );
          }
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
