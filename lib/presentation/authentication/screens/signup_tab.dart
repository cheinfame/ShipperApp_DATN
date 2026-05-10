import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:packare_shipper/presentation/authentication/view_model/authentication_view_model.dart';
import '../global_widgets/info_text_field.dart';
import '../../../config/typography.dart';
import '../global_widgets/rounded_button.dart';

class SignUpTab extends ConsumerStatefulWidget {
  const SignUpTab({Key? key}) : super(key: key);

  @override
  _SignUpTabState createState() => _SignUpTabState();
}

class _SignUpTabState extends ConsumerState<SignUpTab> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // First Name and Last Name Fields
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.445,
                          child: InfoTextField(
                            isObscure: false,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            hintText: 'First Name',
                            label: 'First Name',
                            textFieldController: firstNameController,
                            formValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.445,
                          child: InfoTextField(
                            isObscure: false,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            hintText: 'Last Name',
                            label: 'Last Name',
                            textFieldController: lastNameController,
                            formValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),

                    // Phone Number Field
                    IntlPhoneField(
                      decoration: InputDecoration(
                        label: Text(
                          'Phone Number',
                          style: AppTypography(context: context).bodyText,
                        ),
                        hintText: 'Phone Number',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      initialCountryCode: 'VN',
                      validator: (phone) {
                        if (phone == null || phone.number.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        if (phone.number.length != 9) {
                          return 'Please enter a valid 9-digit phone number';
                        }
                        return null;
                      },
                      onSaved: (phone) {
                        phoneController.text = phone!.completeNumber;
                      },
                      disableLengthCheck: true,
                    ),
                    const SizedBox(height: 10.0),

                    // Username Field
                    InfoTextField(
                      isObscure: false,
                      prefixIcon: Icon(
                        Icons.lock_outline,
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

                    // Password Field
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
                    const SizedBox(height: 10.0),

                    // Confirm Password Field
                    InfoTextField(
                      isObscure: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      hasSuffixObscureIcon: true,
                      hintText: 'Confirm Password',
                      label: 'Confirm Password',
                      textFieldController: confirmPasswordController,
                      formValidator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // Create User Button
                    RoundedButton(
                      text: "Create User",
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Call sign-up method using Riverpod
                          ref.read(authenticationViewModelProvider.notifier).signUp(
                                username: usernameController.text,
                                password: passwordController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phoneNumber: phoneController.text,
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (authState.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
