import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pyramidions_task/core/constants/app_colors.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/utils/screen_utils.dart';
import '../../../data/models/category_model.dart';
import '../widgets/category_item.dart';
import '../widgets/cone_ray_painter.dart';

class CircularMenuWidget extends StatefulWidget {
  // list of categories to show
  final List<CategoryModel> categories;
  const CircularMenuWidget({super.key, required this.categories});

  @override
  State<CircularMenuWidget> createState() => _CircularMenuWidgetState();
}

class _CircularMenuWidgetState extends State<CircularMenuWidget>
    with SingleTickerProviderStateMixin {
  // controls button animations
  late final AnimationController _animationController;
  // order in which buttons animate
  late final List<int> animationOrder;

  // radius of circular menu
  late final double radius;
  // size of each button
  late final double buttonSize;

  static const int buttonAnimMs = 100;
  static const int staggerMs = 75;

  // currently selected button
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    // init radius & size
    radius = 0.35.sw;
    buttonSize = 0.20.sw;

    final totalMs = (buttonAnimMs + staggerMs) * widget.categories.length;

    // setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalMs),
    );

    // figure out button order
    animationOrder = computeAnimationOrder(widget.categories.length);

    // start animation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    // cleanup anim controller
    _animationController.dispose();
    super.dispose();
  }

  // calculate button order based on angles
  List<int> computeAnimationOrder(int count) {
    // final startAngle = -3 * pi / 4;
    final startAngle = -pi / 6;

    final angles = List.generate(count, (i) => 2 * pi * i / count);
    final sorted =
        angles.asMap().entries.toList()..sort((a, b) {
          double da = (a.value - startAngle) % (2 * pi);
          double db = (b.value - startAngle) % (2 * pi);
          return da.compareTo(db);
        });
    return sorted.map((e) => e.key).toList();
  }

  // calculate animation progress for each button
  double progressForIndex(int index) {
    final order = animationOrder.indexOf(index);
    final total = _animationController.duration!.inMilliseconds;
    final start = (buttonAnimMs + staggerMs) * order / total;
    final end = start + buttonAnimMs / total;
    final t = _animationController.value;
    if (t <= start) return 0.0;
    if (t >= end) return 1.0;
    return (t - start) / (end - start);
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.categories;

    // menu container size
    final double menuSize = 0.8.sw;
    // home hub size
    final double hubSize = 0.25.sw;

    return Center(
      child: SizedBox(
        width: menuSize,
        height: menuSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // draw background rays
            Positioned.fill(
              child: CustomPaint(
                painter: ConeRayPainter(
                  buttonsCount: items.length,
                  radius: radius,
                ),
              ),
            ),

            // loop thru categories and render buttons
            for (int i = 0; i < items.length; i++)
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  // final angle = 2 * pi * i / items.length;
                  final angle = -2 * pi * i / items.length - pi / 2;

                  final targetOffset = Offset(
                    radius * cos(angle),
                    radius * sin(angle),
                  );
                  final progress = Curves.easeOut.transform(
                    progressForIndex(i),
                  );
                  final currentOffset =
                      Offset.lerp(Offset.zero, targetOffset, progress)!;

                  return Transform.translate(
                    offset: currentOffset,
                    child: Opacity(
                      opacity: progress.clamp(0.0, 1.0),
                      child: child,
                    ),
                  );
                },
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(buttonSize / 2),
                    onTap: () {
                      // mark selected button
                      setState(() {
                        selectedIndex = i;
                      });
                      print("Tapped on ${items[i].name}");
                    },
                    child: Semantics(
                      label: items[i].name,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 150),
                        scale: selectedIndex == i ? 1.1 : 1.0,
                        child: Container(
                          width: buttonSize,
                          height: buttonSize,
                          decoration: BoxDecoration(
                            color:
                                selectedIndex == i
                                    ? AppColors.glassTint
                                    : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CategoryItem(
                            category: items[i],
                            imageSize: 0.12.sw,
                            isSelected: selectedIndex == i,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // central home hub
            Container(
              width: hubSize,
              height: hubSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF7247E8), Color(0xFF48308C)],
                ),
              ),
              child: Center(
                child: Image.asset(
                  AppImages.sticker,
                  width: 0.18.sw,
                  height: 0.18.sw,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
