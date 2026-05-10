import 'dart:io';
import 'package:flutter/services.dart';
import 'package:packare_shipper/data/services/local/secure_storage_service.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../models/account_model.dart';
import '../services/api/user_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  final SecureStorageService _secureStorage;

  UserRepositoryImpl({
    required UserService userApiService,
    required SecureStorageService secureStorageService,
  })  : _userService = userApiService,
        _secureStorage = secureStorageService;

  @override
  Future<Account> updateUserProfile(Account account) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response =
          await _userService.updateUserProfile(token, account.user);
      final updatedUser = User.fromJson(response['user']);

      // Update the user field in the existing account data
      final updatedAccount = account.copyWith(user: updatedUser);
      return updatedAccount;
    } catch (error) {
      print('Error updating user profile: $error');
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _userService.changePassword(token, currentPassword, newPassword);
    } catch (error) {
      print('Error changing password: $error');
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<Account> getUserProfile(String id) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _userService.getUserProfile(token, id);

      final account = Account.fromJson(response['account']);

      return account;
    } catch (error) {
      print('Error getting profile: $error');
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }
}
