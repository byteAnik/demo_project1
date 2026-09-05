import 'dart:io';

import 'package:demo_project1/features/home/data/model/course_model.dart';
import 'package:demo_project1/features/home/data/repository/course_repository.dart';
import 'package:demo_project1/features/home/getx_controller/home_controller.dart';
import 'package:demo_project1/features/home/presentation/home_screen.dart';
import 'package:demo_project1/helpers/di.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  setUpAll(() async {
    final Directory tempDir = await Directory.systemTemp.createTemp(
      'demo_project1_test',
    );

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async {
            return tempDir.path;
          },
        );

    await GetStorage.init();
    diSetup();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Shows course home screen', (WidgetTester tester) async {
    Get.put(HomeController(repository: _FakeCourseRepository()));

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) {
          return const GetMaterialApp(home: HomeScreen());
        },
      ),
    );

    expect(find.text('Courses'), findsOneWidget);
  });
}

class _FakeCourseRepository extends CourseRepository {
  @override
  Future<CourseResponseModel> fetchCourses() async {
    return CourseResponseModel();
  }
}
