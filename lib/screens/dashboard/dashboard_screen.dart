import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/controllers/profile_controller.dart';
import 'package:payuung/controllers/promo_controller.dart';
import 'package:payuung/entities/promo/promo_entity.dart';
import 'package:payuung/helpers/global_helper.dart';
import 'package:payuung/screens/edit_profile/edit_profile_screen.dart';
import 'package:payuung/screens/promo_detail/promo_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _AppBar(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(14).copyWith(bottom: 110),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DummyTabs(),
                  _FinancialProductsSection(),
                  _CategorySection(),
                  _ExploreWellnessSection(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// * Sections

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return Obx(
      () {
        final fullName = c.profile.value?.biodata.fullName;
        final firstName = fullName?.split(' ')[0] ?? '-';
        final initial = fullName?[0] ?? '-';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: Constants.primaryColor,
          child: SafeArea(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      firstName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const IconButton(
                  onPressed: null,
                  icon: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 7,
                          child: Text(
                            '0',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(() => EditProfileScreen()),
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      initial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DummyTabs extends StatelessWidget {
  const _DummyTabs();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.fromLTRB(4, 8, 4, 20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'Payuung Pribadi',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Payuung Karyawan',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.2), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreWellnessSection extends StatelessWidget {
  const _ExploreWellnessSection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PromoController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore Wellness',
          style: Constants.styleH2,
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (c.status.value == PromoStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final promos = c.promos;

          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.83,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: promos.length,
            itemBuilder: (context, index) => _PromoGridItem(promos[index]),
          );
        }),
      ],
    );
  }
}

class _FinancialProductsSection extends StatelessWidget {
  const _FinancialProductsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Financial Products',
          style: Constants.styleH2,
        ),
        const SizedBox(height: 12),
        GridView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _IconButtonItem(
              title: 'Group\nPayment',
              svgPath: Constants.iconGroup,
            ),
            _IconButtonItem(
              title: 'Hajj\nPayment',
              svgPath: Constants.iconOfficer,
            ),
            _IconButtonItem(
              title: 'Financial\nCheck-Up',
              svgPath: Constants.iconFinance,
            ),
            _IconButtonItem(
              title: 'Car\nInsurance',
              svgPath: Constants.iconCar,
            ),
            _IconButtonItem(
              title: 'Property\nInsurance',
              svgPath: Constants.iconHome,
            ),
          ],
        ),
      ],
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: Constants.styleH2,
        ),
        const SizedBox(height: 12),
        GridView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _IconButtonItem(
              title: 'Hobbies',
              svgPath: Constants.iconBike,
            ),
            _IconButtonItem(
              title: 'Merchandise',
              svgPath: Constants.iconMerchandise,
            ),
            _IconButtonItem(
              title: 'Healthy\nLiving',
              svgPath: Constants.iconHealth,
            ),
            _IconButtonItem(
              title: 'Counselling &\nSpirituality',
              svgPath: Constants.iconChat,
            ),
            _IconButtonItem(
              title: 'Self\nDevelopment',
              svgPath: Constants.iconSelfDevelopment,
            ),
            _IconButtonItem(
              title: 'Financial\nPlanning',
              svgPath: Constants.iconPlan,
            ),
            _IconButtonItem(
              title: 'Health\nConsultation',
              svgPath: Constants.iconMedic,
            ),
            _IconButtonItem(
              title: 'All Categories',
              svgPath: Constants.iconAll,
            ),
          ],
        ),
      ],
    );
  }
}

// * Widgets

class _IconButtonItem extends StatelessWidget {
  const _IconButtonItem({
    required this.title,
    required this.svgPath,
  });

  final String title;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(svgPath, width: 30),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PromoGridItem extends StatelessWidget {
  const _PromoGridItem(this.promo);

  final PromoEntity promo;

  @override
  Widget build(BuildContext context) {
    final price = GlobalHelper.formatToRupiah(promo.price);
    final discountedPrice = GlobalHelper.formatToRupiah(promo.discountedPrice);
    final percentage = GlobalHelper.formatToDiscount(promo.discountPercentage);
    final isDiscounted = promo.discountPercentage > 0;

    const imageHeight = 90.0;
    const priceFontSize = 11.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Constants.primaryColorLight,
          onTap: () => Get.to(() => PromoDetailScreen(promo: promo)),
          child: Ink(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: promo.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
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
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 38,
                        child: Text(
                          promo.title,
                          style: const TextStyle(fontSize: 13),
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            price,
                            style: isDiscounted
                                ? const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: priceFontSize,
                                    color: Colors.black54,
                                  )
                                : const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 6),
                          if (isDiscounted)
                            Text(
                              percentage,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: priceFontSize,
                              ),
                            ),
                        ],
                      ),
                      if (isDiscounted)
                        Text(
                          discountedPrice,
                          style: const TextStyle(fontSize: 13),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
