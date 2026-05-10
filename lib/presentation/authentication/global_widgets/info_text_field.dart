import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoTextField extends StatefulWidget {
  final bool isObscure;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? hasSuffixObscureIcon;
  final bool readOnly;
  final String hintText;
  final String label;
  final TextEditingController textFieldController;
  final FormFieldValidator<String>? formValidator;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final VoidCallback? onSuffixPressed;

  const InfoTextField({
    Key? key,
    this.isObscure = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hasSuffixObscureIcon = false,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.label,
    required this.textFieldController,
    this.formValidator,
    this.inputFormatters,
    this.suffixText,
    this.onChanged,
    this.focusNode,
    this.onSuffixPressed,
  }) : super(key: key);

  @override
  _InfoTextFieldState createState() => _InfoTextFieldState();
}

class _InfoTextFieldState extends State<InfoTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    // Initialize _isObscured based on the initial value of widget.isObscure
    _isObscured = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textFieldController,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      validator: widget.formValidator,
      obscureText: _isObscured, // Use the local _isObscured state
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(context),
        labelText: widget.label,
        hintText: widget.hintText,
        suffixText: widget.suffixText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: widget.suffixIcon!,
        onPressed: widget.onSuffixPressed,
      );
    } else if (widget.hasSuffixObscureIcon == true) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility : Icons.visibility_off,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: _toggleObscure, // Toggle visibility when icon is tapped
      );
    }
    return null;
  }

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured; // Toggle the visibility state
    });
  }
}
