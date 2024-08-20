import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/entities/promo/promo_entity.dart';
import 'package:payuung/helpers/global_helper.dart';

class PromoDetailScreen extends StatelessWidget {
  const PromoDetailScreen({super.key, required this.promo});

  final PromoEntity promo;

  @override
  Widget build(BuildContext context) {
    const imageHeight = 180.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blueGrey),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEFEFEF),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _SectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: promo.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        height: imageHeight,
                        width: double.infinity,
                        imageUrl: promo.imageUrl,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (_, __, ___) => Container(
                          height: imageHeight,
                          width: double.infinity,
                          color: Constants.primaryColor,
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          height: imageHeight,
                          width: double.infinity,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          promo.title,
                          style: Constants.styleH2,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  ),
                  const Text('Voucher Digital', style: Constants.styleBody2),
                ],
              ),
            ),
            _SectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    GlobalHelper.formatToRupiah(promo.discountedPrice),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Stok Tersedia : 100',
                    style: Constants.styleBody2,
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Text(
                        'Min. Pembelian : 1',
                        style: Constants.styleBody2,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Maks. Pembelian : 1',
                        style: Constants.styleBody2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _SectionContainer(
              child: Text(promo.description, style: Constants.styleBody2),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      child: child,
    );
  }
}
