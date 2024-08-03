import 'package:delivery/common/const/colors.dart';
import 'package:delivery/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image imgae;
  final String name;
  final String detail;
  final int price;
  const ProductCard(
      {super.key,
      required this.imgae,
      required this.name,
      required this.detail,
      required this.price});

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
        imgae: Image.network(model.imgUrl, width: 110, height: 110),
        name: model.name,
        detail: model.detail,
        price: model.price);
  }

  @override
  Widget build(BuildContext context) {
    //IntrinsicHeight : 모든 위젯들이 최대 높이의 위젯만큽 똑같은 높이를 차지하게
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: imgae,
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              Text(
                detail,
                // 최대 글자수를 지나가면 ... 표시
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontSize: 14.0,
                ),
              ),
              Text(
                '$price 원',
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              )
            ],
          ))
        ],
      ),
    );
  }
}
