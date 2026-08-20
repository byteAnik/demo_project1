// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:nigom_kotha_flutter/constants/app_assets/assets_image.dart';
// import 'package:nigom_kotha_flutter/constants/app_colors.dart';
// import 'package:nigom_kotha_flutter/features/auth/login/presentation/login_screen.dart';
// import 'package:nigom_kotha_flutter/helpers/ui_helpers.dart';

// final List<Map<String, dynamic>> onboardingList = [
//   {
//     "title": "আধ্যাত্মিক জাগরণ",
//     "description":
//         "সদগুরুর দর্শন ও বাণী আপনার জীবনে আনুক শান্তির পরশ এবং আধ্যাত্মিক জাগরণ।",
//     "image": AssetsImages.sadguruDarshan,
//   },
//   {
//     "title": "ভক্তি ও প্রেম",
//     "description":
//         "ঈশ্বরের প্রতি অকৃত্রিম ভক্তি ও প্রেমের মাধ্যমেই পরম শান্তি লাভ সম্ভব।",
//     "image": AssetsImages.sadguruDarshan,
//   },
//   {
//     "title": "আত্মশুদ্ধি",
//     "description":
//         "নিজেকে জানুন এবং আত্মশুদ্ধির মাধ্যমে জীবনের প্রকৃত অর্থ খুঁজে নিন।",
//     "image": AssetsImages.sadguruDarshan,
//   },
// ];

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _ctrl = PageController();
//   int _page = 0;

//   void _next() {
//     if (_page < onboardingList.length - 1) {
//       _ctrl.nextPage(
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       // Navigate to next screen
//       Get.to(() => LoginScreen());
//     }
//   }

//   void _skip() {
//     _ctrl.animateToPage(
//       onboardingList.length - 1,
//       duration: const Duration(milliseconds: 350),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//     );

//     return Scaffold(
//       backgroundColor: AppColors.cF9FAFB,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 // ── Top illustration and Content ──────────────────────────────
//                 Expanded(
//                   flex: 4,
//                   child: PageView.builder(
//                     controller: _ctrl,
//                     itemCount: onboardingList.length,
//                     onPageChanged: (value) {
//                       setState(() {
//                         _page = value;
//                       });
//                     },
//                     itemBuilder: (_, index) {
//                       final data = onboardingList[index];
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 24.w),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               data["image"],
//                               height: 250.h,
//                               fit: BoxFit.contain,
//                               color: AppColors.cf5efe0,
//                               colorBlendMode: BlendMode.multiply,
//                             ),
//                             UIHelper.verticalSpace(40.h),
//                             Text(
//                               data["title"],
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 30.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.c2A120D,
//                               ),
//                             ),
//                             UIHelper.verticalSpace(15.h),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 30.w),
//                               child: Divider(
//                                 color: AppColors.cC99800.withOpacity(0.3),
//                                 thickness: 1.5,
//                               ),
//                             ),
//                             UIHelper.verticalSpace(15.h),
//                             Text(
//                               data["description"],
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.c4E3B2A,
//                                 height: 1.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 // ── Bottom Section ─────────────────────────────────────────────
//                 Expanded(
//                   flex: 1,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 24.w),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         // ── Indicator ────────────────────────────────────────
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(onboardingList.length, (index) {
//                             final isActive = index == _page;
//                             return AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               margin: EdgeInsets.symmetric(horizontal: 4.w),
//                               width: isActive ? 28.w : 10.w,
//                               height: 8.h,
//                               decoration: BoxDecoration(
//                                 color: isActive
//                                     ? AppColors.cC99800
//                                     : AppColors.cC99800.withOpacity(0.3),
//                                 borderRadius: BorderRadius.circular(4.r),
//                               ),
//                             );
//                           }),
//                         ),
//                         UIHelper.verticalSpace(35.h),

//                         // ── Button ───────────────────────────────────────────
//                         SizedBox(
//                           width: double.infinity,
//                           height: 54.h,
//                           child: ElevatedButton(
//                             onPressed: _next,
//                             style: ElevatedButton.styleFrom(
//                               elevation: 0,
//                               backgroundColor: AppColors.c2A120D,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14.r),
//                               ),
//                             ),
//                             child: Text(
//                               _page == onboardingList.length - 1
//                                   ? 'শুরু করুন'
//                                   : 'পরবর্তী',
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.cC99800,
//                               ),
//                             ),
//                           ),
//                         ),
//                         UIHelper.verticalSpace(36.h),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // ── Skip ───────────────────────────────────────────────────────────
//             if (_page < onboardingList.length - 1)
//               Positioned(
//                 top: 10.h,
//                 right: 20.w,
//                 child: GestureDetector(
//                   onTap: _skip,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.r),
//                     child: Text(
//                       'এড়িয়ে যান',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.cC99800,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
