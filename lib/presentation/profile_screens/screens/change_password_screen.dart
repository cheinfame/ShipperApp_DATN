import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/presentation/profile_screens/view_model/profile_view_model.dart';
import '../../../config/typography.dart';

@RoutePage()
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isObscureCurrent = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change password',
          style: AppTypography(context: context).title3,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildPasswordField(
                controller: _currentPasswordController,
                label: 'Current Password',
                obscureText: _isObscureCurrent,
                toggleObscure: () => setState(() => _isObscureCurrent = !_isObscureCurrent),
              ),
              _buildPasswordField(
                controller: _newPasswordController,
                label: 'New Password',
                obscureText: _isObscureNew,
                toggleObscure: () => setState(() => _isObscureNew = !_isObscureNew),
              ),
              _buildPasswordField(
                controller: _newPasswordConfirmController,
                label: 'Confirm New Password',
                obscureText: _isObscureConfirm,
                toggleObscure: () => setState(() => _isObscureConfirm = !_isObscureConfirm),
                validator: (value) => value != _newPasswordController.text ? 'Confirm Passwords do not match' : null,
              ),
              const SizedBox(height: 16),
              _buildConfirmButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback toggleObscure,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleObscure,
        ),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) return 'Password cannot be empty';
        if (value.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _showConfirmationDialog(context);
              }
            },
            child: Text(
              'Confirm',
              style: AppTypography(context: context).subhead.copyWith(color: Colors.lightBlue),
            ),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          content: Text('Confirm to change your password?', style: AppTypography(context: context).bodyText),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: AppTypography(context: context).subhead.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _onChangePassword(context, _currentPasswordController.text, _newPasswordController.text);
              },
              child: Text('OK', style: AppTypography(context: context).subhead.copyWith(color: Colors.lightBlue)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onChangePassword(BuildContext context, String currentPassword, String newPassword) async {
    try {
      await ref.read(profileViewModelProvider).changePassword(currentPassword, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully'), duration: Duration(seconds: 1)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to change password. Please try again.'), duration: Duration(seconds: 1)),
      );
    }
  }
}
