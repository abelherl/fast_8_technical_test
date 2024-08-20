import 'package:dartz/dartz.dart';
import 'package:payuung/entities/profile/profile_entity.dart';
import 'package:payuung/failures/failure.dart';
import 'package:payuung/repositories/profile_repository.dart';

class SaveProfileInfoUsecase {
  SaveProfileInfoUsecase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, ProfileEntity>> call(ProfileEntity profile) async {
    return await repository.saveProfileInfo(profile);
  }
}