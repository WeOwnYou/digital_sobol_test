import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/extensions/duration_extensions.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:digital_sobol_test/src/features/authentication/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

const _kSendAgainPadding = 44.0;

class VerificatingPage extends StatelessWidget {
  const VerificatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kSecondaryContentPadding,
            ),
            child: _BuildEnterCodeDescription(
              phoneNumber: state.phone.formattedPhone,
            ),
          ),
          const SizedBox(height: kMainPadding),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kSecondaryContentPadding),
            child: PinField(),
          ),
          const SizedBox(height: _kSendAgainPadding),
          _BuildSendAgain(verificationTimeout: state.verificationTimeout),
        ],
      ),
    );
  }
}

class _BuildEnterCodeDescription extends StatelessWidget {
  final String phoneNumber;
  const _BuildEnterCodeDescription({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Введите код, который мы отправили в SMS на $phoneNumber',
      style: Theme.of(context)
          .textTheme
          .displayMedium
          ?.copyWith(fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }
}

const kPinHeight = 35.0;
const kPinWidth = 40.0;
const kCaretRadius = 5.0;

class PinField extends StatelessWidget {
  const PinField({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle:
          Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
      textStyle:
          Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.underline,
        selectedColor: AppColors.inactiveGrey,
        activeColor: AppColors.inactiveGrey,
        inactiveColor: AppColors.inactiveGrey,
        borderRadius: BorderRadius.circular(kCaretRadius),
        fieldHeight: kPinHeight,
        fieldWidth: kPinWidth,
        activeFillColor: Colors.white,
      ),
      cursorColor: Colors.black,
      animationDuration: kAnimationDuration,
      keyboardType: TextInputType.number,
      boxShadows: const [],
      onCompleted: (pin) {
        context.read<AuthenticationCubit>().logIn(smsCode: pin);
      },
    );
  }
}

class _BuildSendAgain extends StatelessWidget {
  final Duration? verificationTimeout;
  const _BuildSendAgain({required this.verificationTimeout});

  @override
  Widget build(BuildContext context) {
    final isTimerRunning = verificationTimeout.isNotOver;
    late final Text textToDisplay;
    if (isTimerRunning) {
      textToDisplay = Text(
        '${verificationTimeout!.inSeconds} сек для повторной отправки кода',
        style: Theme.of(context).textTheme.displayMedium,
      );
    } else {
      textToDisplay = Text(
        'Отправить код еще раз',
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(color: AppColors.mainYellow),
      );
    }
    return GestureDetector(
      onTap: isTimerRunning
          ? null
          : () {
              context.read<AuthenticationCubit>().sendSms();
            },
      child: textToDisplay,
    );
  }
}
