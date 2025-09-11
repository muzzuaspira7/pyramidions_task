import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyramidions_task/features/categories/view/category_screen.dart';
import 'core/utils/screen_utils.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtils.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const CategoryScreen(),
        );
      },
    );
  }
}
