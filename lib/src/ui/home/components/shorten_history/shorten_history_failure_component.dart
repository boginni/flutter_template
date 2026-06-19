import 'package:error_handler_with_result/error_handler_with_result.dart';
import 'package:flutter/material.dart';

class ShortenHistoryFailureComponent extends StatelessWidget {
  const ShortenHistoryFailureComponent({
    super.key,
    required this.failure,
  });

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Text(
              failure.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
