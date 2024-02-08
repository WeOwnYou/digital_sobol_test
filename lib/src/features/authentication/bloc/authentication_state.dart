part of 'authentication_cubit.dart';

enum AuthenticationStage {
  loading,
  enteringNumber,
  verification,
  enteringName,
  home,
}

final class AuthenticationState extends Equatable {
  final Phone phone;
  final AuthenticationStage authenticationStage;
  final Duration? verificationTimeout;
  final String? _verificationId;

  const AuthenticationState({
    required this.phone,
    required this.authenticationStage,
    required this.verificationTimeout,
    String? verificationId,
  }) : _verificationId = verificationId;

  factory AuthenticationState.initial() => const AuthenticationState(
        phone: Phone.empty,
        authenticationStage: AuthenticationStage.loading,
        verificationTimeout: null,
      );

  factory AuthenticationState.verificating({
    required Phone phone,
    required String verificationId,
  }) =>
      AuthenticationState(
        phone: phone,
        authenticationStage: AuthenticationStage.verification,
        verificationTimeout: kVerificationDuration,
        verificationId: verificationId,
      );

  factory AuthenticationState.enteringName(Phone phone) => AuthenticationState(
        authenticationStage: AuthenticationStage.enteringName,
        verificationTimeout: null,
        phone: phone,
      );

  // factory AuthenticationState.signedIn() => const AuthenticationState(
  //       phoneNumber: '',
  //       authenticationStage: AuthenticationStage.enteringName,
  //       verificationTimeout: null,
  //     );

  factory AuthenticationState.home() => const AuthenticationState(
        phone: Phone.empty,
        authenticationStage: AuthenticationStage.home,
        verificationTimeout: null,
      );

  AuthenticationState copyWith({
    Phone? phone,
    AuthenticationStage? authenticationStage,
    Duration? verificationTimeout,
    String? verificationId,
  }) {
    return AuthenticationState(
      phone: phone ?? this.phone,
      authenticationStage: authenticationStage ?? this.authenticationStage,
      verificationTimeout: verificationTimeout ?? this.verificationTimeout,
      verificationId: verificationId ?? _verificationId,
    );
  }

  @override
  List<Object?> get props =>
      [phone, authenticationStage, verificationTimeout, _verificationId];
}

extension AuthenticationStageExtension on AuthenticationStage {
  bool get isEnteringNumberStage => this == AuthenticationStage.enteringNumber;
  bool get isVerificationStage => this == AuthenticationStage.verification;
  bool get isEnteringNameStage => this == AuthenticationStage.enteringName;
  bool get isHomeStage => this == AuthenticationStage.home;
  bool get isLoading => this == AuthenticationStage.loading;
}
