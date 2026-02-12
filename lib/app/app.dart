import 'package:flutter/material.dart';
import 'theme.dart';
import 'routes.dart';

class AttendlyApp extends StatelessWidget {
  const AttendlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendly',
      debugShowCheckedModeBanner: false,
      theme: AttendlyTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
