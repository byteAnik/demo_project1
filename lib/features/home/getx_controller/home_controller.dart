import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_project1/features/home/data/model/course_model.dart';
import 'package:demo_project1/features/home/data/repository/course_repository.dart';
import 'package:demo_project1/helpers/di.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CourseRepository _repository;
  final RxList<CourseModel> courses = <CourseModel>[].obs;
  final Rx<RxStatus> status = RxStatus.loading().obs;
  final RxBool isOffline = false.obs;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  HomeController({CourseRepository? repository})
    : _repository = repository ?? CourseRepository();

  @override
  void onInit() {
    super.onInit();
    _loadCachedCourses();
    fetchCourses(showLoading: courses.isEmpty);
    _listenConnectivity();
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  Future<void> fetchCourses({bool showLoading = true}) async {
    if (showLoading) {
      status.value = RxStatus.loading();
    }

    try {
      final CourseResponseModel response = await _repository.fetchCourses();
      courses.assignAll(response.courses);
      appData.write(_cacheKey, response.toJson());

      if (courses.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        status.value = RxStatus.success();
      }
    } catch (error) {
      if (courses.isNotEmpty) {
        status.value = RxStatus.success();
        return;
      }

      status.value = RxStatus.error(error.toString());
    }
  }

  CourseModel? findCourseById(int id) {
    return courses.firstWhereOrNull((course) => course.id == id);
  }

  void _loadCachedCourses() {
    final dynamic cachedData = appData.read(_cacheKey);

    if (cachedData is! Map) {
      return;
    }

    final CourseResponseModel cachedResponse = CourseResponseModel.fromJson(
      Map<String, dynamic>.from(cachedData),
    );

    if (cachedResponse.courses.isEmpty) {
      return;
    }

    courses.assignAll(cachedResponse.courses);
    status.value = RxStatus.success();
  }

  void _listenConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      final bool hasConnection =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);
      final bool wasOffline = isOffline.value;

      isOffline.value = !hasConnection;

      if (wasOffline && hasConnection) {
        fetchCourses(showLoading: false);
      }
    });
  }

  static const String _cacheKey = 'cached_course_response';
}
