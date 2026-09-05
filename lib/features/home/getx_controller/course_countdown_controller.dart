import 'dart:async';

import 'package:demo_project1/features/home/data/model/course_model.dart';
import 'package:get/get.dart';

class CourseCountdownController extends GetxController {
  final CourseModel course;
  final RxString remainingText = ''.obs;
  Timer? _timer;

  CourseCountdownController({required this.course});

  @override
  void onInit() {
    super.onInit();
    _updateCountdown();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdown(),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _updateCountdown() {
    if (!course.hasActiveDiscount || course.discountEndDate == null) {
      remainingText.value = '';
      return;
    }

    final Duration remaining = course.discountEndDate!.difference(
      DateTime.now(),
    );

    if (remaining.isNegative) {
      remainingText.value = '';
      return;
    }

    final int days = remaining.inDays;
    final int hours = remaining.inHours.remainder(24);
    final int minutes = remaining.inMinutes.remainder(60);
    final int seconds = remaining.inSeconds.remainder(60);

    remainingText.value =
        'Offer ends in ${days}d ${_twoDigits(hours)}h ${_twoDigits(minutes)}m ${_twoDigits(seconds)}s';
  }

  String _twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }
}
