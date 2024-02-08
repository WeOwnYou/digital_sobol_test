import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/features/authentication/widgets/custom_elevated_button.dart';
import 'package:digital_sobol_test/src/features/authentication/widgets/custom_text_field.dart';
import 'package:digital_sobol_test/src/features/home/ui/home_view.dart';
import 'package:digital_sobol_test/src/features/user/bloc/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kSaveButtonPadding = 62.5;

class EnterNamePage extends StatefulWidget {
  const EnterNamePage({super.key});

  @override
  State<EnterNamePage> createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  late final TextEditingController nameController;
  late final TextEditingController surnameController;

  @override
  void initState() {
    nameController = TextEditingController();
    surnameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalContentPadding),
      child: Column(
        children: [
          CustomTextField(
            title: 'Имя',
            textEditingController: nameController,
          ),
          const SizedBox(height: kMainPadding / 2),
          CustomTextField(
            title: 'Фамилия',
            textEditingController: surnameController,
          ),
          const SizedBox(height: kSecondaryPadding),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (ctx) => BlocProvider(
                    create: (ctx) => UserCubit(
                      name: nameController.text,
                      surname: surnameController.text,
                    ),
                    child: const HomeView(),
                  ),
                ),
              );
            },
            textContent: 'Сохранить',
            margin: const EdgeInsets.symmetric(horizontal: kSaveButtonPadding),
          ),
        ],
      ),
    );
  }
}
