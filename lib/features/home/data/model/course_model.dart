class CourseResponseModel {
  final List<CourseModel> courses;

  const CourseResponseModel({this.courses = const []});

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    final dynamic coursesJson = json['courses'];

    return CourseResponseModel(
      courses: coursesJson is List
          ? coursesJson
                .whereType<Map>()
                .map((course) => CourseModel.fromJson(course))
                .toList()
          : const [],
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
  final bool orderStatus;

  const CourseModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.banner,
    required this.discountType,
    required this.discountAmount,
    required this.discountStartDate,
    required this.discountEndDate,
    required this.altText,
    required this.bannerTitle,
    required this.durationInMonth,
    required this.totalClass,
    required this.totalExam,
    required this.totalLive,
    required this.orderStatus,
  });

  factory CourseModel.fromJson(Map<dynamic, dynamic> json) {
    return CourseModel(
      id: _toInt(json['id']),
      title: _toString(json['title']),
      subTitle: _toString(json['sub_title']),
      price: _toInt(json['price']),
      banner: _toString(json['banner']),
      discountType: _toInt(json['discount_type']),
      discountAmount: _toInt(json['discount_amount']),
      discountStartDate: _toDateTime(json['discount_start_date']),
      discountEndDate: _toDateTime(json['discount_end_date']),
      altText: _toString(json['alt_text']),
      bannerTitle: _toString(json['banner_title']),
      durationInMonth: _toString(json['duration_in_month']),
      totalClass: _toString(json['total_class']),
      totalExam: _toInt(json['total_exam']),
      totalLive: _toInt(json['total_live']),
      orderStatus: _toBool(json['order_status']),
    );
  }

  bool get hasActiveDiscount {
    if (discountType == 0 || discountAmount <= 0 || discountEndDate == null) {
      return false;
    }

    final DateTime now = DateTime.now();
    final bool hasStarted =
        discountStartDate == null || !now.isBefore(discountStartDate!);
    final bool hasNotEnded = now.isBefore(discountEndDate!);

    return hasStarted && hasNotEnded;
  }

  int get payablePrice {
    if (!hasActiveDiscount) {
      return price;
    }

    final int discount = discountType == 2
        ? (price * discountAmount / 100).round()
        : discountAmount;

    return (price - discount).clamp(0, price);
  }

  String get heroTag => 'course-banner-$id';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'sub_title': subTitle,
      'price': price,
      'banner': banner,
      'discount_type': discountType,
      'discount_amount': discountAmount,
      'discount_start_date': _formatDateTime(discountStartDate),
      'discount_end_date': _formatDateTime(discountEndDate),
      'alt_text': altText,
      'banner_title': bannerTitle,
      'duration_in_month': durationInMonth,
      'total_class': totalClass,
      'total_exam': totalExam,
      'total_live': totalLive,
      'order_status': orderStatus.toString(),
    };
  }

  static String _toString(dynamic value) {
    return value?.toString() ?? '';
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    return value?.toString().toLowerCase() == 'true';
  }

  static DateTime? _toDateTime(dynamic value) {
    final String date = value?.toString() ?? '';
    if (date.isEmpty) {
      return null;
    }

    return DateTime.tryParse(date.replaceFirst(' ', 'T'));
  }

  static String? _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }

    final String year = dateTime.year.toString().padLeft(4, '0');
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }
}
