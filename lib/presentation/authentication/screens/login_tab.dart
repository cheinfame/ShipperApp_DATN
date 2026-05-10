import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/presentation/authentication/view_model/authentication_view_model.dart';
import 'package:packare_shipper/router/app_router.dart';
import '../global_widgets/info_text_field.dart';
import '../../main_screen.dart';
import '../../../config/typography.dart';
import '../global_widgets/rounded_button.dart';

class LoginTab extends ConsumerStatefulWidget {
  const LoginTab({Key? key}) : super(key: key);

  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends ConsumerState<LoginTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationViewModelProvider);
    final authViewModel = ref.watch(authenticationViewModelProvider.notifier);

    // Show loading indicator while login is in progress
    if (authState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show error dialog if login fails
    if (authState.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(authState.errorMessage!);
      });
    }

    // Navigate to main screen if logged in
    if (authState.isLoggedIn) {
      context.router.replaceAll([const MainRoute()]);
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                InfoTextField(
                  isObscure: false,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  hintText: 'Username',
                  label: 'Username',
                  textFieldController: usernameController,
                  formValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    } else if (value.length < 6) {
                      return 'Username must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                InfoTextField(
                  isObscure: true,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  hasSuffixObscureIcon: true,
                  hintText: 'Password',
                  label: 'Password',
                  textFieldController: passwordController,
                  formValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                RoundedButton(
                  text: "Login",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final username = usernameController.text;
                      final password = passwordController.text;

                      // Call the login function from Riverpod's view model
                      authViewModel.login(username, password);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            errorMessage,
            style: AppTypography(context: context).bodyText,
          ),
        );
      },
    );
  }
}
