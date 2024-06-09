import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const CustomCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.w),
      child: SizedBox(
        height: 100.h, // Establece un tamaño fijo para el Column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 50.sp,
                color: iconColor),
            SizedBox(height: 2.h),
            Text(
              title,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
