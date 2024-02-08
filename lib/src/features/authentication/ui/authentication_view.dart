import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:digital_sobol_test/src/core/ui/app_svgs.dart';
import 'package:digital_sobol_test/src/features/authentication/bloc/authentication_cubit.dart';
import 'package:digital_sobol_test/src/features/authentication/ui/entering_name_page.dart';
import 'package:digital_sobol_test/src/features/authentication/ui/entering_number_page.dart';
import 'package:digital_sobol_test/src/features/authentication/ui/verificating_page.dart';
import 'package:digital_sobol_test/src/features/home/ui/home_view.dart';
import 'package:digital_sobol_test/src/features/user/bloc/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  late int pageIndex;
  late final PageController pageController;

  @override
  void initState() {
    pageIndex =
        context.read<AuthenticationCubit>().state.authenticationStage.index - 1;
    pageController = PageController(initialPage: pageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (pageIndex == 0) return;
            context.read<AuthenticationCubit>().changeAuthenticationStage(
                  AuthenticationStage.values[pageIndex],
                );
          },
          icon: SvgPicture.asset(AppSVGs.keyboardArrowLeft),
        ),
      ),
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        buildWhen: (oldState, newState) {
          if (oldState.authenticationStage == newState.authenticationStage) {
            return false;
          }
          final pageIndex = newState.authenticationStage.index - 1;
          setState(() {
            this.pageIndex = pageIndex;
            pageController.animateToPage(
              pageIndex,
              duration: kAnimationDuration,
              curve: Curves.easeIn,
            );
          });
          return true;
        },
        builder: (context, state) {
          if (state.authenticationStage.isHomeStage) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (ctx) => BlocProvider(
                    create: (ctx) => UserCubit(
                      name: '',
                      surname: '',
                    ),
                    child: const HomeView(),
                  ),
                ),
              );
            });
          }
          return SafeArea(
            child: (state.authenticationStage.isLoading ||
                    state.authenticationStage.isHomeStage)
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _BuildAuthenticationProgressBar(pageIndex: pageIndex),
                      _BuildAuthenticationStageTitle(
                        authenticationStage: state.authenticationStage,
                      ),
                      const SizedBox(height: kMainPadding),
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            EnteringNumbersPage(),
                            VerificatingPage(),
                            EnterNamePage(),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

const _authenticationTitlePadding = 50.0;

class _BuildAuthenticationStageTitle extends StatelessWidget {
  final AuthenticationStage authenticationStage;
  const _BuildAuthenticationStageTitle({required this.authenticationStage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: _authenticationTitlePadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kMainPadding),
            child: Text(
              authenticationStage.isVerificationStage
                  ? 'Подтверждение'
                  : 'Регистрация',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          if (authenticationStage.isEnteringNumberStage)
            Text(
              'Введите номер телефона для регистрации',
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

const _authenticationStageBarPadding = 90.0;

class _BuildAuthenticationProgressBar extends StatelessWidget {
  final int pageIndex;
  const _BuildAuthenticationProgressBar({required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    final numberToDisplay = pageIndex + 1;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _authenticationStageBarPadding,
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: _authenticationStageWidget / 2),
            height: 1,
            color: AppColors.mainGrey,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              final authenticationStep = AuthenticationStage.values[index + 1];
              final isSelected = numberToDisplay == authenticationStep.index;
              return AuthenticationStageWidget(
                numberToDisplay: index + 1,
                isSelected: isSelected,
                isPassed: numberToDisplay > authenticationStep.index,
              );
            }),
          ),
        ],
      ),
    );
  }
}

const _authenticationStageWidget = 36.0;

class AuthenticationStageWidget extends StatelessWidget {
  final int numberToDisplay;
  final bool isSelected;
  final bool isPassed;
  const AuthenticationStageWidget({
    super.key,
    required this.numberToDisplay,
    required this.isSelected,
    required this.isPassed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _authenticationStageWidget,
      height: _authenticationStageWidget,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isPassed
            ? AppColors.white
            : isSelected
                ? AppColors.mainYellow
                : AppColors.mainGrey,
        border: isPassed ? Border.all(color: AppColors.green) : null,
      ),
      child: Center(
        child: isPassed
            ? SvgPicture.asset(AppSVGs.checkboxIcon)
            : Text(
                '$numberToDisplay',
                style: Theme.of(context).textTheme.displayMedium,
              ),
      ),
    );
  }
}
