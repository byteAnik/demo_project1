import 'package:demo_project1/features/home/data/model/course_model.dart';
import 'package:demo_project1/networks/endpoints.dart' as endpoints;
import 'package:dio/dio.dart';

class CourseRepository {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<CourseResponseModel> fetchCourses() async {
    final Response response = await _dio.get(endpoints.url!);
    final Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

    return CourseResponseModel.fromJson(data);
  }
}
