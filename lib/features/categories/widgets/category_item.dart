import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pyramidions_task/core/utils/screen_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final double imageSize;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.category,
    this.imageSize = 43,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: category.image,
          width: imageSize.w,
          height: imageSize.h,
          fit: BoxFit.contain,
          placeholder:
              (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: imageSize.w,
                  height: imageSize.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          errorWidget:
              (context, url, error) => Container(
                width: imageSize.w,
                height: imageSize.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.broken_image,
                  size: 28,
                  color: Colors.redAccent,
                ),
              ),
        ),

        SizedBox(height: 4.h),

        // Label
        Flexible(
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
