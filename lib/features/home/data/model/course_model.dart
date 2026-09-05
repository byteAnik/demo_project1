import 'package:intl/intl.dart';

class CourseResponseModel {
  final List<CourseModel> courses;

  CourseResponseModel({this.courses = const []});

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseResponseModel(
      courses:
          (json['courses'] as List<dynamic>?)
              ?.map((course) => CourseModel.fromJson(course))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'courses': courses.map((course) => course.toJson()).toList()};
  }
}

class CourseModel {
  final int id;
  final String title;
  final String subTitle;
  final int price;
  final String banner;
  final int discountType;
  final int discountAmount;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;
  final String altText;
  final String bannerTitle;
  final String durationInMonth;
  final String totalClass;
  final int totalExam;
  final int totalLive;
  final String orderStatus;

  CourseModel({
    this.id = 0,
    this.title = '',
    this.subTitle = '',
    this.price = 0,
    this.banner = '',
    this.discountType = 0,
    this.discountAmount = 0,
    this.discountStartDate,
    this.discountEndDate,
    this.altText = '',
    this.bannerTitle = '',
    this.durationInMonth = '',
    this.totalClass = '',
    this.totalExam = 0,
    this.totalLive = 0,
    this.orderStatus = 'false',
  });

  bool get hasActiveDiscount {
    final DateTime now = DateTime.now();

    if (discountAmount <= 0 ||
        discountStartDate == null ||
        discountEndDate == null) {
      return false;
    }

    return now.isAfter(discountStartDate!) && now.isBefore(discountEndDate!);
  }

  int get payablePrice {
    if (!hasActiveDiscount) {
      return price;
    }

    return (price - discountAmount).clamp(0, price);
  }

  String get heroTag => 'course_banner_$id';

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: _parseInt(json['id']),
      title: json['title']?.toString() ?? '',
      subTitle: json['sub_title']?.toString() ?? '',
      price: _parseInt(json['price']),
      banner: json['banner']?.toString() ?? '',
      discountType: _parseInt(json['discount_type']),
      discountAmount: _parseInt(json['discount_amount']),
      discountStartDate: _parseDate(json['discount_start_date']),
      discountEndDate: _parseDate(json['discount_end_date']),
      altText: json['alt_text']?.toString() ?? '',
      bannerTitle: json['banner_title']?.toString() ?? '',
      durationInMonth: json['duration_in_month']?.toString() ?? '',
      totalClass: json['total_class']?.toString() ?? '',
      totalExam: _parseInt(json['total_exam']),
      totalLive: _parseInt(json['total_live']),
      orderStatus: json['order_status']?.toString() ?? 'false',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'sub_title': subTitle,
      'price': price,
      'banner': banner,
      'discount_type': discountType,
      'discount_amount': discountAmount,
      'discount_start_date': _formatDate(discountStartDate),
      'discount_end_date': _formatDate(discountEndDate),
      'alt_text': altText,
      'banner_title': bannerTitle,
      'duration_in_month': durationInMonth,
      'total_class': totalClass,
      'total_exam': totalExam,
      'total_live': totalLive,
      'order_status': orderStatus,
    };
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _parseDate(dynamic value) {
    final String date = value?.toString() ?? '';

    if (date.isEmpty) {
      return null;
    }

    return DateFormat('yyyy-MM-dd HH:mm').tryParse(date);
  }

  static String? _formatDate(DateTime? value) {
    if (value == null) {
      return null;
    }

    return DateFormat('yyyy-MM-dd HH:mm').format(value);
  }
}
