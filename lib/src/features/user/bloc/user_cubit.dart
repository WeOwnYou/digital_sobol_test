import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final String name;
  final String surname;
  UserCubit({required this.name, required this.surname})
      : super(UserState.initial(name: name, surname: surname));

  void enterName({required String name, required String surname}) =>
      emit(state.copyWith(name: name, surname: surname));

  void editName({required String name}) => emit(state.copyWith(name: name));

  void editSurname({required String surname}) =>
      emit(state.copyWith(surname: surname));

  void enterEmail({required String email}) =>
      emit(state.copyWith(email: email));

  void changeProfilePicture({required Uint8List profilePicture}) =>
      emit(state.copyWith(profilePicture: profilePicture));
}
