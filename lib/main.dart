import 'package:flutter/material.dart';

import 'src/ui/app/app_dependencies.dart';
import 'src/ui/app/app_routes.dart';
import 'src/ui/app/app_widget.dart';
import 'src/ui/app/controllers/app_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppDependencies.init();

  runApp(
    AppWidget(
      controller: AppController(
        AppDependencies.get(),
        appRoutes: AppRoutes(),
      ),
    ),
  );
}
