import 'package:flutter_mrz_scanner/src/mrz_parser/mrz_validity.dart';

enum Sex { none, male, female }

class MRZResult {
  const MRZResult({
    required this.documentType,
    required this.countryCode,
    required this.surnames,
    required this.givenNames,
    required this.documentNumber,
    required this.nationalityCountryCode,
    required this.birthDate,
    required this.sex,
    required this.expiryDate,
    required this.personalNumber,
    this.personalNumber2,
    required this.validity,
  });

  final String documentType;
  final String countryCode;
  final String surnames;
  final String givenNames;
  final String documentNumber;
  final String nationalityCountryCode;
  final DateTime birthDate;
  final String sex;
  final DateTime expiryDate;
  final String personalNumber;
  final String? personalNumber2;
  final MRZValidity validity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MRZResult &&
          runtimeType == other.runtimeType &&
          documentType == other.documentType &&
          countryCode == other.countryCode &&
          surnames == other.surnames &&
          givenNames == other.givenNames &&
          documentNumber == other.documentNumber &&
          nationalityCountryCode == other.nationalityCountryCode &&
          birthDate == other.birthDate &&
          sex == other.sex &&
          expiryDate == other.expiryDate &&
          personalNumber == other.personalNumber &&
          personalNumber2 == other.personalNumber2 &&
          validity == other.validity;

  @override
  int get hashCode =>
      documentType.hashCode ^
      countryCode.hashCode ^
      surnames.hashCode ^
      givenNames.hashCode ^
      documentNumber.hashCode ^
      nationalityCountryCode.hashCode ^
      birthDate.hashCode ^
      sex.hashCode ^
      expiryDate.hashCode ^
      personalNumber.hashCode ^
      personalNumber2.hashCode ^
      validity.hashCode;
}
