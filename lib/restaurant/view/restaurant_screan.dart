import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/dio/dio.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScrean extends StatelessWidget {
  const RestaurantScrean({super.key});

//future 로 왜 반환하는가> async로 함수를 선언했기 떄문
//왜 async로 선언을 했냐 Http로 요청을 받을거기 떄문
  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(CustomInterceptor(storage: storage));

    final resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List<RestaurantModel>>(
              future: paginateRestaurant(),
              builder:
                  (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    color: PRIMARY_COLOR,
                  );
                } else {
                  print("error : ${snapshot.error}");
                }

                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final pItem = snapshot.data![index];
                    //factory construcor를 사용한 데이터 모델링
                    //final pItem = RestaurantModel.fromJson(item);
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
                );
              },
            )),
      ),
    );
  }
}
