// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:nigom_kotha_flutter/constants/app_assets/assets_image.dart';
// import 'package:nigom_kotha_flutter/constants/app_colors.dart';
// import 'package:nigom_kotha_flutter/features/auth/login/presentation/login_screen.dart';
// import 'package:nigom_kotha_flutter/helpers/ui_helpers.dart';
// import 'package:nigom_kotha_flutter/onboarding_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Timer(const Duration(seconds: 3), () {
//       // এখানে তোমার next screen-এর navigation দাও
//       Get.off(() => const OnboardingScreen());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cF9FAFB,
//       body: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 AssetsImages.bookScrenImage,
//                 width: 300.w,
//                 fit: BoxFit.contain,
//                 color: AppColors.cf5efe0,
//                 colorBlendMode: BlendMode.multiply,
//               ),
//               UIHelper.verticalSpace(20.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 40.w),
//                 child: Divider(
//                   color: AppColors.cC99800.withOpacity(0.3),
//                   thickness: 1.5,
//                 ),
//               ),
//               UIHelper.verticalSpace(5.h),
//               Text(
//                 'সদগুরু দর্শন',
//                 style: TextStyle(
//                   fontSize: 36.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.c2A120D,
//                 ),
//               ),
//               UIHelper.verticalSpace(5.h),
//               Text(
//                 'SADGURU DARSHAN',
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.cC99800,
//                   letterSpacing: 6.0,
//                 ),
//               ),
//               UIHelper.verticalSpace(10.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 40.w),
//                 child: Divider(
//                   color: AppColors.cC99800.withOpacity(0.3),
//                   thickness: 1.5,
//                 ),
//               ),
//               UIHelper.verticalSpace(10.h),
//               Text(
//                 'গুরু ব্রহ্মা গুরু বিষ্ণু গুরুদেব মহেশ্বরঃ',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.c4E3B2A,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
