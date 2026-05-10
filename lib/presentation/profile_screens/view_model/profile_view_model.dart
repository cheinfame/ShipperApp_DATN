import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/repositories/auth_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/data/repositories/user_repository_impl.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/authentication/view_model/authentication_view_model.dart';
import 'package:packare_shipper/presentation/navigating/navigating_screen.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';

final profileViewModelProvider = Provider<ProfileViewModel>(
  (ref) => ProfileViewModel(
    ref: ref,
    shippingRepository: locator<ShippingRepositoryImpl>(),
    userRepository: locator<UserRepositoryImpl>(),
    authRepository: locator<AuthRepositoryImpl>(),
  ),
);

class ProfileViewModel {
  ProfileViewModel({
    required this.ref,
    required this.shippingRepository,
    required this.userRepository,
    required this.authRepository,
  });

  final Ref ref;

  final ShippingRepositoryImpl shippingRepository;

  final UserRepositoryImpl userRepository;

  final AuthRepositoryImpl authRepository;

  Future<void> configMaxDistance(
      Account shipperAccount, double newMaxDistance) async {
    try {
      await shippingRepository.updateShipperMaxDistance(
          shipperAccount.shipper!.shipperId, newMaxDistance);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      await userRepository.changePassword(currentPassword, newPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile(Account updatedAccountInfo) async {
    try {
      await userRepository.updateUserProfile(updatedAccountInfo);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout()async {
    await ref.read(authenticationViewModelProvider.notifier).logout();
  }
}
