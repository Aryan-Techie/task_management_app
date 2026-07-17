// shown when the API call fails
// message comes from the error object so it's always relevant to what actually went wrong
import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final String message;

  const ErrorWidgetCustom({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}