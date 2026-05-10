import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isLoggedIn,
  }) = _AuthenticationState;
}
