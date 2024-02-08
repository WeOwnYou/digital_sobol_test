part of 'user_cubit.dart';

final class UserState extends Equatable {
  final String name;
  final String surname;
  final String email;
  final Uint8List? profilePicture;
  const UserState({
    required this.name,
    required this.surname,
    required this.email,
    this.profilePicture,
  });

  factory UserState.initial({required String name, required String surname}) =>
      UserState(name: name, surname: surname, email: '');

  UserState copyWith({
    String? name,
    String? surname,
    String? email,
    Uint8List? profilePicture,
  }) {
    return UserState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [
        name,
        surname,
        email,
        profilePicture,
      ];
}
