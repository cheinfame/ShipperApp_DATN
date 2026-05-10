import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/models/user_model.dart';
import 'package:packare_shipper/data/models/wallet_model.dart';
import 'package:packare_shipper/data/repositories/auth_repository_impl.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import 'authentication_state.dart';
import 'package:packare_shipper/data/models/account_model.dart';

final authenticationViewModelProvider =
    StateNotifierProvider<AuthenticationViewModel, AuthenticationState>(
  (ref) => AuthenticationViewModel(
    ref: ref,
    authRepository: locator<AuthRepositoryImpl>(),
  ),
);

class AuthenticationViewModel extends StateNotifier<AuthenticationState> {
  AuthenticationViewModel({
    required this.ref,
    required this.authRepository,
  }) : super(const AuthenticationState());

  final AuthRepositoryImpl authRepository;

  final Ref ref;

  // Login function
  Future<void> login(String username, String password) async {
    try {
      state = state.copyWith(isLoading: true);

      final account = await authRepository.login(username, password);

      // Cache the account and set the login state
      ref.read(accountViewModelProvider.notifier).setAccount(account);

      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Login failed: $e',
        isLoggedIn: false,
      );
    }
  }

  // Sign Up function
  Future<void> signUp({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      // Validation passed, proceed with form submission
      final user = User(
        userId: '',
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        orderHistory: [],
      );

      final wallet = Wallet(
        userId: '',
        balance: 0.0,
        transactionHistory: [],
      );

      final account = Account(
        username: username,
        password: password,
        user: user,
        wallet: wallet,
      );

      await authRepository.signUp(account);

      // Cache the account and set the login state
      ref.read(accountViewModelProvider.notifier).setAccount(account);

      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Signup failed: $e',
        isLoggedIn: false,
      );
    }
  }

  // Logout function
  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);

      await authRepository.logout();
      await FlutterForegroundTask.stopService();

      state = state.copyWith(
        isLoading: false,
        isLoggedIn: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Logout failed: $e',
      );
    }
  }
}
