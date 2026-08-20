// // ignore_for_file: deprecated_member_use
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nigom_kotha_flutter/constants/app_assets/assets_icons.dart';
// import 'package:nigom_kotha_flutter/constants/app_colors.dart';
// import 'package:nigom_kotha_flutter/features/book_history_flow/book/presentation/book_screen.dart';
// import 'package:nigom_kotha_flutter/features/home_section/home_screen.dart';
// import 'package:nigom_kotha_flutter/features/profile_section_flow/profile_screen/profile_screen.dart';
// import 'package:nigom_kotha_flutter/features/video_fow_section/video/presentation/video_screen.dart';
// import 'helpers/helper_methods.dart';

// class NavigationScreen extends StatefulWidget {
//   final int? pageNum;
//   const NavigationScreen({super.key, this.pageNum});

//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> {
//   late int _currentIndex;

//   List<Widget> get screens => [
//     BookScreen(),
//     VideoScreen(),
//     HomeHomeScreen(),
//     ProfileSettingsScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.pageNum ?? 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         showMaterialDialog(context);
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         extendBody: true,
//         body: SafeArea(child: screens[_currentIndex]),
//         bottomNavigationBar: SafeArea(
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//             decoration: BoxDecoration(
//               color: AppColors.cFFFFFF,
//               borderRadius: BorderRadius.circular(30.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withAlpha((0.1 * 255).toInt()),
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(30.r),
//               child: BottomNavigationBar(
//                 elevation: 0,
//                 backgroundColor: Colors.transparent,
//                 currentIndex: _currentIndex,
//                 onTap: (index) => setState(() => _currentIndex = index),
//                 type: BottomNavigationBarType.fixed,
//                 selectedItemColor: AppColors.appsBlue,
//                 unselectedItemColor: AppColors.c000000,
//                 showUnselectedLabels: false,
//                 selectedLabelStyle: const TextStyle(
//                   fontWeight: FontWeight.w500,
//                 ),
//                 unselectedLabelStyle: const TextStyle(
//                   fontWeight: FontWeight.w400,
//                 ),
//                 items: [
//                   _buildNavItem(
//                     Image.asset(
//                       AssetsIcons.bookIcoon,
//                       height: 24.h,
//                       width: 24.w,
//                       color: _currentIndex == 0
//                           ? AppColors.appsBlue
//                           : AppColors.c000000,
//                     ),
//                     "Book",
//                   ),
//                   _buildNavItem(
//                     Image.asset(
//                       AssetsIcons.videoIcon,
//                       height: 24.h,
//                       width: 24.w,
//                       color: _currentIndex == 1
//                           ? AppColors.appsBlue
//                           : AppColors.c000000,
//                     ),
//                     "Video",
//                   ),
//                   _buildNavItem(
//                     Image.asset(
//                       AssetsIcons.homeIcon,
//                       height: 24.h,
//                       width: 24.w,
//                       color: _currentIndex == 2
//                           ? AppColors.appsBlue
//                           : AppColors.c000000,
//                     ),
//                     "Home",
//                   ),
//                   _buildNavItem(
//                     Image.asset(
//                       AssetsIcons.settingsIcon,
//                       height: 24.h,
//                       width: 24.w,
//                       color: _currentIndex == 3
//                           ? AppColors.appsBlue
//                           : AppColors.c000000,
//                     ),
//                     "Settings",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   BottomNavigationBarItem _buildNavItem(Widget iconWidget, String label) {
//     return BottomNavigationBarItem(icon: iconWidget, label: label);
//   }
// }
