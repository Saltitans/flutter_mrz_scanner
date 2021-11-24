class MRZValidity {
  const MRZValidity({
    this.documentNumber = false,
    this.birthDate = false,
    this.expirityDate = false,
    this.finalString = false,
  });

  final bool documentNumber;
  final bool birthDate;
  final bool expirityDate;
  final bool finalString;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MRZValidity &&
          documentNumber == other.documentNumber &&
          birthDate == other.birthDate &&
          expirityDate == other.expirityDate &&
          finalString == other.finalString;

  @override
  int get hashCode =>
      documentNumber.hashCode ^
      birthDate.hashCode ^
      expirityDate.hashCode ^
      finalString.hashCode;
}
