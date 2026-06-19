import 'dart:async';

import 'package:custom_go_router/custom_go_router.dart';
import 'package:flutter/material.dart';

import '../shell/shell_routes.dart';
import 'splash_controller.dart';
import 'splash_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    required this.controller,
    super.key,
  });

  final SplashController controller;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController get controller => widget.controller;

  SplashStore get store => controller.store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        initialize();
      },
    );
  }

  Future<void> initialize() async {
    try {
      await controller.appController.init();
    } finally {
      await navigate();
    }
  }

  Future<void> navigate() async {
    context.goToRoute(ShellRoute());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: switch (store.state) {
              SplashStoreLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            },
          ),
        );
      },
    );
  }
}
