import 'package:dartz/dartz.dart';
import 'package:payuung/datasources/profile_datasource.dart';
import 'package:payuung/entities/profile/profile_entity.dart';
import 'package:payuung/failures/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfileInfo();
  Future<Either<Failure, ProfileEntity>> saveProfileInfo(ProfileEntity profile);
}

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl(this.datasource);

  final ProfileDatasource datasource;

  @override
  Future<Either<Failure, ProfileEntity>> getProfileInfo() async {
    return await datasource.getProfileInfo();
  }

  @override
  Future<Either<Failure, ProfileEntity>> saveProfileInfo(ProfileEntity profile,) async {
    return await datasource.saveProfileInfo(profile);
  }
}