import 'package:flutter/material.dart';

class ShortenHistoryLoadingComponent extends StatelessWidget {
  const ShortenHistoryLoadingComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverPadding(
          padding: .symmetric(horizontal: 16),
          sliver: SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
