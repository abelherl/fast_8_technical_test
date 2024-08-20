import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/entities/profile/profile_entity.dart';
import 'package:payuung/failures/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileDatasource {
  Future<Either<Failure, ProfileEntity>> getProfileInfo();
  Future<Either<Failure, ProfileEntity>> saveProfileInfo(ProfileEntity profile);
}

class ProfileDatasourceImpl extends ProfileDatasource {
  ProfileDatasourceImpl(this.prefs);

  final SharedPreferences prefs;

  @override
  Future<Either<Failure, ProfileEntity>> getProfileInfo() async {
    final json = prefs.getString(Constants.prefsProfile);

    if (json == null) {
      return Left(
        DatabaseFailure(message: 'Profile data not found'),
      );
    }

    try {
      final profile = ProfileEntity.fromJson(jsonDecode(json));
      return Right(profile);
    } catch (e) {
      return Left(UnknownFailure(message: 'Parsing failure'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> saveProfileInfo(
    ProfileEntity profile,
  ) async {
    try {
      final json = profile.toJson();

      await prefs.setString(Constants.prefsProfile, jsonEncode(json));

      return Right(profile);
    } catch (e) {
      return Left(UnknownFailure(message: 'Unknown failure'));
    }
  }
}
