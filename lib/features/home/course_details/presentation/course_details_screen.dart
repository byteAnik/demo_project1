import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project1/constants/app_colors.dart';
import 'package:demo_project1/features/home/data/model/course_model.dart';
import 'package:demo_project1/features/home/getx_controller/home_controller.dart';
import 'package:demo_project1/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  static const String _courseBannerUrl =
      'https://storage.biddabari.online/biddabari-bucket/backend/assets/uploaded-files/course/course-banners/courses-1785592301-771938478695716.webp';

  @override
  Widget build(BuildContext context) {
    final int courseId = Get.arguments as int;
    final HomeController controller = Get.find<HomeController>();
    final CourseModel? course = controller.findCourseById(courseId);

    if (course == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Course not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: AppBar(
        title: Text(
          'Course Details',
          style: TextStyle(
            color: AppColors.c222222,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.c222222),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: course.heroTag,
              child: CachedNetworkImage(
                imageUrl: _courseBannerUrl,
                height: 230.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  height: 230.h,
                  color: AppColors.cF3F3F3,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: TextStyle(
                      color: AppColors.c222222,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    course.subTitle,
                    style: TextStyle(
                      color: AppColors.c6B6B6B,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Text(
                    '৳ ${course.payablePrice}',
                    style: TextStyle(
                      color: AppColors.c0F9D69,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  UIHelper.verticalSpace(18.h),
                  _DetailsRow(
                    label: 'Duration',
                    value: '${course.durationInMonth} Month',
                  ),
                  _DetailsRow(label: 'Total Class', value: course.totalClass),
                  _DetailsRow(
                    label: 'Total Exam',
                    value: '${course.totalExam}',
                  ),
                  _DetailsRow(
                    label: 'Total Live',
                    value: '${course.totalLive}',
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

class _DetailsRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailsRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.c6B6B6B,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors.c222222,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
