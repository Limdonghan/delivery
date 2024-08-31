import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/dio/dio.dart';
import 'package:delivery/common/layout/default_layout.dart';
import 'package:delivery/product/component/product_card.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  //레스토랑 id
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();

    //interceptor
    dio.interceptors.add(CustomInterceptor(storage: storage));

    //_RestaurantRepository retrofit
    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "음식 타이틀",
        child: FutureBuilder<RestaurantDetailModel>(
            future: getRestaurantDetail(),
            builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              //final item = RestaurantDetailModel.fromJson(snapshot.data!);
              return CustomScrollView(
                slivers: [
                  renderTop(
                    model: snapshot.data!,
                  ),
                  renderLable(),
                  renderProducts(
                    products: snapshot.data!.products,
                  ),
                ],
              );
            }));
  }

  SliverPadding renderLable() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantDetailModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final model = products[index];
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ProductCard.fromModel(
            model: model,
          ),
        );
      }, childCount: products.length)),
    );
  }
}
