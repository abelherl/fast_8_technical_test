import 'package:json_annotation/json_annotation.dart';

part 'company_entity.g.dart';

@JsonSerializable()
class CompanyEntity {
  CompanyEntity({
    required this.name,
    required this.address,
    required this.position,
    required this.tenure,
    required this.incomeType,
    required this.yearlyGross,
    required this.bankName,
    required this.bankAccountName,
    required this.bankAccountNumber,
  });

  String name;
  String address;
  String position;
  String tenure;
  String incomeType;
  String yearlyGross;
  String bankName;
  int bankAccountNumber;
  String bankAccountName;

  factory CompanyEntity.fromJson(Map<String, dynamic> json) =>
      _$CompanyEntityFromJson(json);

  factory CompanyEntity.dummy() => CompanyEntity(
        name: 'Amazing Co.',
        address: 'Amazing Street 123',
        position: 'Mobile Developer',
        tenure: '1-3 Years',
        incomeType: 'Salary',
        yearlyGross: '10-30 Million',
        bankName: 'Bank Independent',
        bankAccountName: 'John Doe',
        bankAccountNumber: 4301238471231231,
      );

  Map<String, dynamic> toJson() => _$CompanyEntityToJson(this);
}
