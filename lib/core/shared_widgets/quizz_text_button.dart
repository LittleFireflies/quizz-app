import 'package:flutter/material.dart';

class QuizzTextButton extends StatelessWidget {
  const QuizzTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.trailing,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      child: Text(label),
    );
  }
}
