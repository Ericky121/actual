enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

class RestaurantModel {
  // {
  // "id": "5ac83bfb-f2b5-55f4-be3c-564be3f01a5b",
  // "name": "불타는 떡볶이",
  // "thumbUrl": "/img/떡볶이/떡볶이.jpg",
  // "tags": [
  // "떡볶이",
  // "치즈",
  // "매운맛"
  // ],
  // "priceRange": "medium",
  // "ratings": 4.51,
  // "ratingsCount": 100,
  // "deliveryTime": 15,
  // "deliveryFee": 2000
  // },

  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCoount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCoount,
    required this.deliveryTime,
    required this.deliveryFee
  });
}
