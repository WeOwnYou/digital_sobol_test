import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:digital_sobol_test/src/core/ui/app_images.dart';
import 'package:digital_sobol_test/src/core/ui/app_svgs.dart';
import 'package:digital_sobol_test/src/features/home/ui/edit_name_page.dart';
import 'package:digital_sobol_test/src/features/home/widgets/back_button.dart';
import 'package:digital_sobol_test/src/features/user/bloc/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

const kTextFieldPadding = 28.0;

class AccountsPage extends StatelessWidget {
  final void Function() onBackTap;
  const AccountsPage({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Аккаунт',
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        leadingWidth: 132,
        leading: CustomBackButton(
          text: 'Мой аккаунт',
          onTap: onBackTap,
          margin: const EdgeInsets.only(left: kSecondaryPadding / 2),
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (ctx, state) {
          return Column(
            children: [
              const SizedBox(height: kSecondaryPadding),
              const _BuildProfileIcon(),
              const SizedBox(height: kSecondaryPadding / 2),
              Text(
                state.email,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: kTextFieldPadding),
              const _BuildNameField(nameField: NameField.name),
              const _BuildNameField(nameField: NameField.surname),
            ],
          );
        },
      ),
    );
  }
}

const _kFieldColor = Color(0xffFDFDFD);

class _BuildNameField extends StatelessWidget {
  final NameField nameField;
  const _BuildNameField({required this.nameField});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final name = (nameField == NameField.name ? state.name : state.surname);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (ctx) => EditNamePage(
                  nameField: nameField,
                  initialName:
                      nameField == NameField.name ? state.name : state.surname,
                  parentContext: context,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: kSmallPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: kSmallPadding * 2,
              vertical: kSecondaryPadding / 2,
            ),
            decoration: BoxDecoration(
              color: _kFieldColor,
              borderRadius: nameField == NameField.name
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(kSecondaryCircularRadius),
                      topRight: Radius.circular(kSecondaryCircularRadius),
                    )
                  : null,
              border:
                  const Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nameField == NameField.name ? 'Имя' : 'Фамилия',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 16),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name.isEmpty ? 'Настроить' : name,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 16,
                                color: AppColors.bottomNavBarGrey,
                              ),
                    ),
                    const SizedBox(width: kMainPadding / 2),
                    SvgPicture.asset(AppSVGs.keyboardArrowRight),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

const _iconSize = 76.0;
const _moreRadius = 15.0;

class _BuildProfileIcon extends StatefulWidget {
  const _BuildProfileIcon();

  @override
  State<_BuildProfileIcon> createState() => _BuildProfileIconState();
}

class _BuildProfileIconState extends State<_BuildProfileIcon> {
  Uint8List? defaultIcon;

  @override
  void initState() {
    loadSvgBytes();
    super.initState();
  }

  Future<void> loadSvgBytes() async {
    final data = await rootBundle.load(AppImages.defaultIcon);
    final bytes = data.buffer.asUint8List();
    setState(() {
      defaultIcon = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Center(
          child: Stack(
            children: [
              SizedBox(
                width: _iconSize,
                height: _iconSize,
                child: defaultIcon == null
                    ? const CircularProgressIndicator.adaptive()
                    : ClipOval(
                        child: Image.memory(
                          state.profilePicture ?? defaultIcon!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Positioned(
                child: InkWell(
                  child: SvgPicture.asset(AppSVGs.moreIcon),
                  borderRadius: BorderRadius.circular(_moreRadius),
                  onTap: () {
                    showCupertinoModalPopup<bool>(
                      context: context,
                      builder: (ctx) => PickImageAlert(parentContext: context),
                    );
                  },
                ),
                bottom: 0,
                right: 0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class PickImageAlert extends StatelessWidget {
  final BuildContext parentContext;
  const PickImageAlert({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        'Выберите фото',
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Закрыть',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            ImagePicker()
                .pickImage(source: ImageSource.camera)
                .then((pickedImage) {
              pickedImage?.readAsBytes().then(
                    (byteImage) => parentContext
                        .read<UserCubit>()
                        .changeProfilePicture(profilePicture: byteImage),
                  );
              Navigator.pop(context);
            });
          },
          child: Text('Камера', style: Theme.of(context).textTheme.bodyLarge),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ImagePicker()
                .pickImage(source: ImageSource.gallery)
                .then((pickedImage) {
              pickedImage?.readAsBytes().then(
                    (byteImage) => parentContext
                        .read<UserCubit>()
                        .changeProfilePicture(profilePicture: byteImage),
                  );
              Navigator.pop(context);
            });
          },
          child: Text(
            'Галерея фото',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
