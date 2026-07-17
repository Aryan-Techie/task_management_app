// shown when the task list is empty (either API returned nothing or all tasks deleted)
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Tasks Found'),
    );
  }
}