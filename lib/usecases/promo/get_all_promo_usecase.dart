import 'package:dartz/dartz.dart';
import 'package:payuung/entities/promo/promo_entity.dart';
import 'package:payuung/failures/failure.dart';
import 'package:payuung/repositories/promo_repository.dart';

class GetAllPromoUsecase {
  GetAllPromoUsecase(this.repository);

  final PromoRepository repository;

  Future<Either<Failure, List<PromoEntity>>> call() async {
    return await repository.getAllPromo();
  }
}