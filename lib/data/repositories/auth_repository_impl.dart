import 'dart:io';
import 'package:packare_shipper/data/services/local/secure_storage_service.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import '../models/account_model.dart';
import '../repositories/auth_repository.dart';
import '../services/api/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final SharedPreferencesService _sharedPreferencesService;
  final SecureStorageService _secureStorage;

  AuthRepositoryImpl({
    required AuthService authService,
    required SharedPreferencesService sharedPreferencesStorage,
    required SecureStorageService secureStorage,
  })  : _authService = authService,
        _sharedPreferencesService = sharedPreferencesStorage,
        _secureStorage = secureStorage;

  // Login with Cache (only token stored, expiration checked via token itself)
  @override
  Future<Account> loginWithCache() async {
    try {
      // Retrieve cached token from secure storage
      final token = await _secureStorage.getStringValue('token');

      // If token is available, decode it to check if it's still valid
      if (token != null && token.isNotEmpty) {
        final decodedToken = JwtDecoder.decode(token);
        final expirationTime = decodedToken['exp'];

        // If token is valid (not expired)
        if (DateTime.now().isBefore(
            DateTime.fromMillisecondsSinceEpoch(expirationTime * 1000))) {
          // Token is valid, we fetch the account info
          final response = await _authService.loginWithToken(token);

          if (response['account'] != null) {
            final account = Account.fromJson(response['account']);

            await _sharedPreferencesService.setBoolValue('isLoggedIn', true);
            return account;
          } else {
            throw Exception('Failed to fetch account details.');
          }
        } else {
          // Token expired, delete it from secure storage
          await _secureStorage.removeValue('token');
          await _sharedPreferencesService.setBoolValue('isLoggedIn', false);
          await _sharedPreferencesService
              .removeValue('currentNavigatingRouteId');
          await _sharedPreferencesService
              .removeValue('currentNavigatingRouteDirection');
          throw PlatformException(
              code: 'TOKEN_EXPIRED', message: 'Token has expired.');
        }
      } else {
        await _secureStorage.removeValue('token');
        await _sharedPreferencesService.setBoolValue('isLoggedIn', false);
        await _sharedPreferencesService.removeValue('currentNavigatingRouteId');
        await _sharedPreferencesService
            .removeValue('currentNavigatingRouteDirection');
        throw Exception('Session has ended, please login again.');
      }
    } catch (error) {
      throw Exception('Session has ended, please login again.');
    }
  }

  // Login function that caches the token upon successful login
  @override
  Future<Account> login(String username, String password) async {
    try {
      final response =
          await _authService.login(username, password); // Call login API

      final account = Account.fromJson(response['account']);
      account.password = ''; // Remove password from account object for security

      final token = response['token'];

      // Cache token securely (expiration time is embedded in the token itself)
      await _secureStorage.setStringValue('token', token);

      await _sharedPreferencesService.setBoolValue('isLoggedIn', true);

      return account;
    } catch (error) {
      print('Error during login: $error');
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  // Signup function that caches the token upon successful signup
  @override
  Future<Account> signUp(Account signUpAccount) async {
    try {
      final response =
          await _authService.signUp(signUpAccount); // Call signup API

      final account = Account.fromJson(response['account']);
      account.password = ''; // Remove password from account object for security

      final token = response['token'];

      // Cache token securely (expiration time is embedded in the token itself)
      await _secureStorage.setStringValue('token', token);

      return account;
    } catch (error) {
      print('Error during signup: $error');
      rethrow;
    }
  }

  // Logout function that clears cached data
  @override
  Future<void> logout() async {
    try {
      // Clear token from secure storage
      await _secureStorage.removeValue('token');
      await _sharedPreferencesService.setBoolValue('isLoggedIn', false);
      await _sharedPreferencesService.removeValue('currentNavigatingRouteId');
      await _sharedPreferencesService
          .removeValue('currentNavigatingRouteDirection');
    } catch (error) {
      rethrow;
    }
  }
}
