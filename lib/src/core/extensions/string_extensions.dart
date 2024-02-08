extension CustomStringExtension on String? {
  String get formatPhoneNumber => this == null
      ? ''
      : (this!.length != 10)
          ? this!
          : '(${this!.substring(0, 3)}) ${this!.substring(3, 6)} ${this!.substring(6, 8)} ${this!.substring(8)}';
}
