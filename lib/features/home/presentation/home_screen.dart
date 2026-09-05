import 'package:demo_project1/common_wigdets/common_button.dart';
import 'package:demo_project1/constants/app_colors.dart';
import 'package:demo_project1/features/home/getx_controller/home_controller.dart';
import 'package:demo_project1/features/home/presentation/widgets/course_card.dart';
import 'package:demo_project1/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: Column(
            children: [
              UIHelper.verticalSpace(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Courses',
                    style: GoogleFonts.anekBangla(
                      color: AppColors.c222222,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.fetchCourses(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              Obx(() {
                if (!controller.isOffline.value) {
                  return const SizedBox.shrink();
                }

                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 9.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cFFEA94,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'You are offline. Cached courses are showing.',
                    style: GoogleFonts.anekBangla(
                      color: AppColors.c2A120D,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }),
              Expanded(
                child: Obx(() {
                  final RxStatus status = controller.status.value;

                  if (status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (status.isError) {
                    return _StateMessage(
                      icon: Icons.error_outline,
                      title: 'Something went wrong',
                      message: status.errorMessage ?? 'Please try again.',
                      onRetry: () => controller.fetchCourses(),
                    );
                  }

                  if (controller.courses.isEmpty) {
                    return _StateMessage(
                      icon: Icons.school_outlined,
                      title: 'No courses found',
                      message: 'Pull down to refresh.',
                      onRetry: () => controller.fetchCourses(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        controller.fetchCourses(showLoading: false),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                      itemCount: controller.courses.length,
                      itemBuilder: (context, index) {
                        final course = controller.courses[index];

                        return CourseCard(
                          course: course,
                          onTap: () => Get.toNamed(
                            '/course-details',
                            arguments: course.id,
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StateMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final VoidCallback onRetry;

  const _StateMessage({
    required this.icon,
    required this.title,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.c767676, size: 42.sp),
            UIHelper.verticalSpace(12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.anekBangla(
                color: AppColors.c222222,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            UIHelper.verticalSpace(6.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.anekBangla(
                color: AppColors.c6B6B6B,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            UIHelper.verticalSpace(16.h),
            CommonButton(text: 'Retry', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
