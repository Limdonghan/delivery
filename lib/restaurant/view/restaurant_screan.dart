import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScrean extends ConsumerWidget {
  const RestaurantScrean({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<CursorPagination<RestaurantModel>>(
            future: ref.watch(restaurantRespositoryProvider).paginate(),
            builder: (context,
                AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                );
              } else {
                print("error : ${snapshot.error}");
              }

              return ListView.separated(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  final pItem = snapshot.data!.data[index];
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
              );
            },
          ),
        ),
      ),
    );
  }
}
