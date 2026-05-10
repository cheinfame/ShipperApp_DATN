import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:packare_shipper/presentation/profile_screens/view_model/profile_view_model.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import '../../../config/typography.dart';
import '../../../data/models/account_model.dart';
import '../../../presentation/profile_screens/widgets/user_detailed_info_app_bar.dart';

@RoutePage()
class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({
    super.key,
  });

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  bool _isEditState = false;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  Account? get accountInfo => ref.watch(accountViewModelProvider);

  ProfileViewModel get viewModel => ref.read(profileViewModelProvider);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the controllers with the account data
    _firstNameController = TextEditingController(
      text: accountInfo!.user.firstName,
    );
    _lastNameController = TextEditingController(
      text: accountInfo!.user.lastName,
    );
    _phoneController = TextEditingController(
      text: accountInfo!.user.phoneNumber,
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Information',
          style: AppTypography(context: context).title3,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && _isEditState == true) {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      content: Text(
                        'Do you want to save your information?',
                        style: AppTypography(context: context).bodyText,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Text(
                            'Cancel',
                            style: AppTypography(context: context)
                                .subhead
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            _onUpdateProfileSaved(context);
                          },
                          child: Text(
                            'OK',
                            style: AppTypography(context: context)
                                .subhead
                                .copyWith(color: Colors.lightBlue),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              setState(() {
                _isEditState = !_isEditState;
              });
            },
            child: Text(
              _isEditState ? 'Save' : 'Edit',
              style: AppTypography(context: context).bodyText,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const UserDetailedInfoAppBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          readOnly: !_isEditState,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          readOnly: !_isEditState,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  IntlPhoneField(
                    controller: _phoneController,
                    readOnly: !_isEditState,
                    decoration: InputDecoration(
                      prefixIcon: null,
                      label: Text(
                        'Phone Number',
                        style: AppTypography(context: context).bodyText,
                      ),
                      hintText: 'Phone Number',
                    ),
                    initialCountryCode: 'VN',
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      if (phone.number.length != 9) {
                        return 'Please enter a valid 9-digit phone number';
                      }
                      return null; // Return null if validation succeeds
                    },
                    onSaved: (phone) {
                      _phoneController.text = phone!.completeNumber;
                    },
                    disableLengthCheck: true,
                  ),
                ],
              ),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                'Log out',
                style: AppTypography(context: context)
                    .subhead
                    .copyWith(color: Colors.lightBlue),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  void showErrorDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onButtonPressed,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onUpdateProfileSaved(BuildContext context) async {
    final updatedAccount = accountInfo!.copyWith(
      user: accountInfo!.user.copyWith(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneController.text,
      ),
    );

    try {
      if (mounted) {
        await viewModel.updateProfile(updatedAccount);

        ref.read(accountViewModelProvider.notifier).setAccount(updatedAccount);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Information updated successfully'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed updating information. Please try again.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
