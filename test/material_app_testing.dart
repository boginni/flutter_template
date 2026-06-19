import 'package:flutter/material.dart';
import 'package:nu_l10n/nu_l10n.dart';
import 'package:nubank_test/src/ui/app/material_theme.dart';

class MaterialAppTesting extends StatefulWidget {
  const MaterialAppTesting({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  State<MaterialAppTesting> createState() => _MaterialAppTestingState();
}

class _MaterialAppTestingState extends State<MaterialAppTesting> {
  final theme = const MaterialTheme();

  ThemeData get lightTheme => theme.getTheme(
    ThemeData.light(useMaterial3: true),
    usesCustomFont: false,
  );

  ThemeData get darkTheme => theme.getTheme(
    ThemeData.dark(useMaterial3: true),
    usesCustomFont: false,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: NuL10n.localizationsDelegates,
      supportedLocales: NuL10n.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        body: Builder(builder: widget.builder),
      ),
    );
  }
}
