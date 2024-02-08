import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/extensions/duration_extensions.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:digital_sobol_test/src/features/authentication/bloc/authentication_cubit.dart';
import 'package:digital_sobol_test/src/features/authentication/utils/masked_text_input_formatter.dart';
import 'package:digital_sobol_test/src/features/authentication/widgets/custom_elevated_button.dart';
import 'package:digital_sobol_test/src/features/authentication/widgets/custom_text_field.dart';
import 'package:digital_sobol_test/src/models/phone.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnteringNumbersPage extends StatelessWidget {
  const EnteringNumbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      buildWhen: (oldState, newState) {
        final didPhoneChange = oldState.phone != newState.phone;
        if (didPhoneChange && newState.phone.phoneNumber.length == 10) {
          FocusScope.of(context).unfocus();
        }
        return didPhoneChange;
      },
      builder: (context, state) => Column(
        children: [
          _BuildEnterPhoneTextField(state.phone),
          _BuildSendSms(
            isActive: state.phone.phoneNumber.length == 10 &&
                state.verificationTimeout.isOver,
          ),
        ],
      ),
    );
  }
}

class _BuildEnterPhoneTextField extends StatefulWidget {
  final Phone? initialPhone;
  const _BuildEnterPhoneTextField(this.initialPhone);

  @override
  State<_BuildEnterPhoneTextField> createState() =>
      _BuildEnterPhoneTextFieldState();
}

class _BuildEnterPhoneTextFieldState extends State<_BuildEnterPhoneTextField> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController(
      text: widget.initialPhone?.phoneNumber,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kHorizontalContentPadding),
      child: CustomTextField(
        title: 'Номер телефона',
        textInputType: TextInputType.number,
        textEditingController: textEditingController,
        textInputFormatters: [MaskedTextInputFormatter('(xxx) xxx xx xx')],
        onChanged: (phoneNumber) {
          context.read<AuthenticationCubit>().changePhoneNumber(
                phoneNumber.replaceAll(RegExp(r'\D'), ''),
              );
        },
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: kMainPadding,
            top: kSecondaryPadding / 2,
            bottom: kSecondaryPadding / 2,
          ),
          child: Text(
            '${widget.initialPhone?.countryCode ?? '+7'} ',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}

class _BuildSendSms extends StatefulWidget {
  final bool isActive;
  const _BuildSendSms({required this.isActive});

  @override
  State<_BuildSendSms> createState() => _BuildSendSmsState();
}

class _BuildSendSmsState extends State<_BuildSendSms> {
  late bool isLoading;
  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSecondaryContentPadding),
      child: Column(
        children: [
          CustomElevatedButton(
            isActive: widget.isActive,
            isLoading: isLoading,
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              context.read<AuthenticationCubit>().sendSms().then(
                    (value) => setState(() {
                      isLoading = false;
                    }),
                  );
            },
            textContent: 'Отправить смс-код',
            margin: EdgeInsets.only(
              top: 0.1 * MediaQuery.of(context).size.height,
              bottom: 8,
            ),
          ),
          const _BuildSendSmsDescription(
            margin: EdgeInsets.symmetric(horizontal: kSecondaryPadding),
          ),
        ],
      ),
    );
  }
}

class _BuildSendSmsDescription extends StatelessWidget {
  final EdgeInsets margin;
  const _BuildSendSmsDescription({required this.margin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Нажимая на данную кнопку, вы даете согласие на обработку ',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.inactiveGrey),
          children: <TextSpan>[
            TextSpan(
              text: 'персональных данных',
              style: const TextStyle(color: AppColors.mainYellow),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('Url is pressed');
                },
            ),
          ],
        ),
      ),
    );
  }
}
