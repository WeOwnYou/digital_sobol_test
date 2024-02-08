import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/extensions/duration_extensions.dart';
import 'package:digital_sobol_test/src/models/phone.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.initial()) {
    _initialize();
  }

  bool get _isSignedIn => FirebaseAuth.instance.currentUser != null;

  void _initialize() {
    final authenticationStage = _isSignedIn
        ? AuthenticationStage.home
        : AuthenticationStage.enteringNumber;
    return emit(state.copyWith(authenticationStage: authenticationStage));
  }

  void changeAuthenticationStage(AuthenticationStage authenticationStage) =>
      emit(state.copyWith(authenticationStage: authenticationStage));

  void changePhoneNumber(String newPhoneNumber) {
    final newPhone = state.phone.copyWith(phoneNumber: newPhoneNumber);
    return emit(state.copyWith(phone: newPhone));
  }

  Future<void> sendSms() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: kVerificationDuration,
      phoneNumber: '${state.phone.countryCode}${state.phone.phoneNumber}',

      ///This handler will only be called on Android devices which support automatic SMS code resolution.
      verificationCompleted: (credential) async {
        if (_isSignedIn) {
          return emit(AuthenticationState.enteringName(state.phone));
        }
      },
      verificationFailed: (e) {},
      codeSent: (verificationId, resendToken) async {
        emit(
          AuthenticationState.verificating(
            phone: state.phone,
            verificationId: verificationId,
          ),
        );
        _handleTimeout();
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  void _handleTimeout() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.verificationTimeout.isNotOver) {
        emit(
          state.copyWith(
            verificationTimeout:
                Duration(seconds: state.verificationTimeout!.inSeconds - 1),
          ),
        );
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> logIn({required String smsCode}) async {
    if (state._verificationId == null) {
      return;
    }

    if (_isSignedIn) {
      return emit(AuthenticationState.enteringName(state.phone));
    }
  }
}
