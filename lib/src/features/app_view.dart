import 'package:digital_sobol_test/src/core/ui/theme.dart';
import 'package:digital_sobol_test/src/features/authentication/bloc/authentication_cubit.dart';
import 'package:digital_sobol_test/src/features/authentication/ui/authentication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: BlocProvider(
        create: (ctx) => AuthenticationCubit(),
        child: const AuthenticationView(),
      ),
    );
  }
}
