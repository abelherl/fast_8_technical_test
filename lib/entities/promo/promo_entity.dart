import 'package:hive/hive.dart';

part 'promo_entity.g.dart';

@HiveType(typeId: 1)
class PromoEntity extends HiveObject {
  PromoEntity({
    required this.id,
    required this.title,
    this.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    required this.price,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.imageUrl,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final double discountPercentage;
  @HiveField(5)
  final double discountedPrice;
  @HiveField(6)
  final String imageUrl;
}

extension PromoEntityX on PromoEntity {
  static List<PromoEntity> dummyPromos() => [
    PromoEntity(
      id: 0,
      title: 'Coffee Voucher for New User',
      price: 15000,
      discountPercentage: 0,
      discountedPrice: 15000,
      imageUrl: 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
    ),
    PromoEntity(
      id: 1,
      title: 'Tea Voucher for New User',
      price: 20000,
      discountPercentage: 10,
      discountedPrice: 18000,
      imageUrl: 'https://images.pexels.com/photos/904616/pexels-photo-904616.jpeg',
    ),
    PromoEntity(
      id: 2,
      title: 'Mini-market Voucher for August',
      price: 25000,
      discountPercentage: 5,
      discountedPrice: 23750,
      imageUrl: 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ),
    PromoEntity(
      id: 3,
      title: 'Mini-market Voucher for September',
      price: 25000,
      discountPercentage: 0,
      discountedPrice: 25000,
      imageUrl: 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ),
    PromoEntity(
      id: 4,
      title: 'Mini-market Voucher for October',
      price: 25000,
      discountPercentage: 20,
      discountedPrice: 20000,
      imageUrl: 'https://images.pexels.com/photos/3028500/pexels-photo-3028500.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ),
    PromoEntity(
      id: 5,
      title: 'Snack Voucher for New Coffee Shop',
      price: 10000,
      discountPercentage: 0,
      discountedPrice: 10000,
      imageUrl: 'https://images.pexels.com/photos/2788792/pexels-photo-2788792.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ),
    PromoEntity(
      id: 6,
      title: 'Coffee Voucher for New Coffee Shop',
      price: 10000,
      discountPercentage: 0,
      discountedPrice: 10000,
      imageUrl: 'https://images.pexels.com/photos/2788792/pexels-photo-2788792.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ),
  ];
}
