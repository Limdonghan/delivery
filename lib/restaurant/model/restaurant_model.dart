import 'package:delivery/common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

//RestaurantModel 인스턴스화
class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratigns;
  final int ratignsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratigns,
    required this.ratignsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

//factory construcor를 사용해 데이터 모델링
  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantModel(
        id: json['id'],
        name: json['name'],
        thumbUrl: 'http://$ip${json['thumbUrl']}',
        tags: List<String>.from(json['tags']),
        priceRange: RestaurantPriceRange.values
            .firstWhere((e) => e.name == json['priceRange']),
        ratigns: json['ratings'],
        ratignsCount: json['ratingsCount'],
        deliveryTime: json['deliveryTime'],
        deliveryFee: json['deliveryFee']);
  }
}
