import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantScrean extends StatelessWidget {
  const RestaurantScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RestaurantCart(
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg', fit: BoxFit.cover),
            name: '떡볶이', 
            tags: ['떡볶이', '치즈', '매운맛'],
            ratingCount: 100, 
            deliveryTime: 15, 
            deliveryFee: 2000, 
            rating: 4.52),
        ),
      ),
    );
  }
}