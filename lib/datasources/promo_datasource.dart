import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:payuung/entities/promo/promo_entity.dart';
import 'package:payuung/failures/failure.dart';

abstract class PromoDatasource {
  Future<Either<Failure, List<PromoEntity>>> getAllPromo();
}

class PromoDatasourceImpl extends PromoDatasource {
  PromoDatasourceImpl(this.box);

  final Box<PromoEntity> box;

  @override
  Future<Either<Failure, List<PromoEntity>>> getAllPromo() async {
    try {
      final promos = box.values.toList();

      if (promos.isEmpty) {
        final dummy = PromoEntityX.dummyPromos();
        box.clear();
        box.addAll(dummy);
        return Right(box.values.toList());
      }

      return Right(promos);
    } catch (_) {
      return Left(UnknownFailure(message: 'Unknown failure'));
    }
  }
}
