import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/features/home/widgets/back_button.dart';
import 'package:digital_sobol_test/src/features/user/bloc/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NameField { name, surname }

const _editNamePadding = 13.0;

class EditNamePage extends StatefulWidget {
  final BuildContext parentContext;
  final NameField nameField;
  final String initialName;
  const EditNamePage({
    super.key,
    required this.nameField,
    required this.initialName,
    required this.parentContext,
  });

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  late final TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.initialName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hintText =
        widget.nameField == NameField.name ? 'Ваше имя' : 'Ваша фамилия';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          hintText,
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        leadingWidth: 132,
        leading: CustomBackButton(
          text: 'Аккаунт',
          onTap: Navigator.of(context).pop,
          margin: const EdgeInsets.only(left: _editNamePadding),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: kSecondaryPadding,
          left: kSmallPadding,
          right: kSmallPadding,
        ),
        child: CupertinoTextField(
          placeholder: hintText,
          padding: const EdgeInsets.symmetric(
            vertical: _editNamePadding,
            horizontal: kHorizontalContentPadding,
          ),
          controller: nameController,
          onChanged: (newName) {
            if (widget.nameField == NameField.name) {
              widget.parentContext.read<UserCubit>().editName(name: newName);
            } else {
              widget.parentContext
                  .read<UserCubit>()
                  .editSurname(surname: newName);
            }
          },
        ),
      ),
    );
  }
}
