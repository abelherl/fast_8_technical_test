import 'package:dartz/dartz.dart';
import 'package:payuung/datasources/promo_datasource.dart';
import 'package:payuung/entities/promo/promo_entity.dart';
import 'package:payuung/failures/failure.dart';

abstract class PromoRepository {
  Future<Either<Failure, List<PromoEntity>>> getAllPromo();
}

class PromoRepositoryImpl extends PromoRepository {
  PromoRepositoryImpl(this.datasource);

  final PromoDatasource datasource;

  @override
  Future<Either<Failure, List<PromoEntity>>> getAllPromo() async {
    return await datasource.getAllPromo();
  }
}