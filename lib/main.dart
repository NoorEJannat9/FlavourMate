import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealplanner/pages/home_page.dart';
import 'package:mealplanner/theme/app_theme.dart';
import 'package:mealplanner/theme/theme_notifier.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeNotifierProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meal Planner',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}
