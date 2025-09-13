import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../view/circular_menu_widget.dart';
import '../viewmodel/category_viewmodel.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoryViewModelProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.centerGradientStart,
              AppColors.gradientMid1,
              AppColors.gradientMid2,
              AppColors.centerGradientEnd,
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh:
              () => ref.read(categoryViewModelProvider.notifier).reload(),
          child: categoriesState.when(
            loading: () => const LoadingWidget(),
            error:(e, st) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Something went wrong! Please check your internet.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(categoryViewModelProvider.notifier).reload();
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
            data: (categories) {
              return CircularMenuWidget(categories: categories);
            },
          ),
        ),
      ),
    );
  }
}
