import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project1/constants/app_colors.dart';
import 'package:demo_project1/features/home/data/model/course_model.dart';
import 'package:demo_project1/features/home/getx_controller/course_countdown_controller.dart';
import 'package:demo_project1/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CourseCard extends StatefulWidget {
  final CourseModel course;
  final VoidCallback onTap;

  const CourseCard({super.key, required this.course, required this.onTap});

  static const String courseBannerUrl =
      'https://storage.biddabari.online/biddabari-bucket/backend/assets/uploaded-files/course/course-banners/courses-1785592301-771938478695716.webp';

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  late final String _tag;

  @override
  void initState() {
    super.initState();
    _tag = widget.course.id.toString();
    Get.put(CourseCountdownController(course: widget.course), tag: _tag);
  }

  @override
  void dispose() {
    if (Get.isRegistered<CourseCountdownController>(tag: _tag)) {
      Get.delete<CourseCountdownController>(tag: _tag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CourseModel course = widget.course;

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.cE7E8EB),
          boxShadow: [
            BoxShadow(
              color: AppColors.c000000.withValues(alpha: .06),
              blurRadius: 16.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: course.heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
                child: CachedNetworkImage(
                  imageUrl: CourseCard.courseBannerUrl,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 160.h,
                    color: AppColors.cF3F3F3,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 160.h,
                    color: AppColors.cF3F3F3,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.c767676,
                      size: 34.sp,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.c222222,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.30,
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  Text(
                    course.subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.c6B6B6B,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  Row(
                    children: [
                      Text(
                        '৳ ${course.payablePrice}',
                        style: TextStyle(
                          color: AppColors.c0F9D69,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (course.hasActiveDiscount) ...[
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          '৳ ${course.price}',
                          style: TextStyle(
                            color: AppColors.c8B8A8C,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  UIHelper.verticalSpace(12.h),
                  Obx(() {
                    final CourseCountdownController controller =
                        Get.find<CourseCountdownController>(tag: _tag);

                    if (controller.remainingText.value.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cE6F2FF,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          controller.remainingText.value,
                          style: TextStyle(
                            color: AppColors.c1A4878,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _StatIndicator(
                        icon: Icons.calendar_month_outlined,
                        label: '${course.durationInMonth} Month',
                      ),
                      _StatIndicator(
                        icon: Icons.menu_book_outlined,
                        label: '${course.totalClass} Class',
                      ),
                      _StatIndicator(
                        icon: Icons.quiz_outlined,
                        label: '${course.totalExam} Exam',
                      ),
                      _StatIndicator(
                        icon: Icons.live_tv_outlined,
                        label: '${course.totalLive} Live',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatIndicator extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatIndicator({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.cF7F7F7,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.c525866),
          UIHelper.horizontalSpace(5.w),
          Text(
            label,
            style: TextStyle(
              color: AppColors.c525866,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
