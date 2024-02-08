import 'package:flutter/cupertino.dart';

@immutable
class Phone {
  final String phoneNumber;
  final String countryCode;

  const Phone({required this.phoneNumber, this.countryCode = '+7'});

  static const empty = Phone(phoneNumber: '');
  bool get isEmpty => this == empty;

  String get formattedPhone =>
      '$countryCode(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6, 8)} ${phoneNumber.substring(8)}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phone &&
          runtimeType == other.runtimeType &&
          phoneNumber == other.phoneNumber &&
          countryCode == other.countryCode);

  @override
  int get hashCode => phoneNumber.hashCode ^ countryCode.hashCode;

  @override
  String toString() {
    return 'Phone{ phoneNumber: $phoneNumber, countryCode: $countryCode, formattedPhone: $formattedPhone,}';
  }

  Phone copyWith({String? phoneNumber, String? countryCode}) {
    return Phone(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}
