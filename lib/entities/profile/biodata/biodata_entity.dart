import 'package:json_annotation/json_annotation.dart';

part 'biodata_entity.g.dart';

@JsonSerializable()
class BiodataEntity {
  BiodataEntity({
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.educationLevel,
    required this.marriageStatus,
  });

  String fullName;
  DateTime birthDate;
  String gender;
  String email;
  int phoneNumber;
  String educationLevel;
  String marriageStatus;

  factory BiodataEntity.fromJson(Map<String, dynamic> json) =>
      _$BiodataEntityFromJson(json);

  factory BiodataEntity.dummy() => BiodataEntity(
        fullName: 'John Doe',
        birthDate: DateTime(2002, 4, 30),
        gender: 'Male',
        email: 'johndoe@gmail.com',
        phoneNumber: 08967948274,
        educationLevel: 'S1',
        marriageStatus: 'Married',
      );

  Map<String, dynamic> toJson() => _$BiodataEntityToJson(this);
}
