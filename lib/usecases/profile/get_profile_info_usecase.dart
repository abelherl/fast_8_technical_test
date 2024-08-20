import 'package:dartz/dartz.dart';
import 'package:payuung/entities/profile/profile_entity.dart';
import 'package:payuung/failures/failure.dart';
import 'package:payuung/repositories/profile_repository.dart';

class GetProfileInfoUsecase {
  GetProfileInfoUsecase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, ProfileEntity>> call() async {
    return await repository.getProfileInfo();
  }
}