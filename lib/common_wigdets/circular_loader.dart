import 'package:demo_project1/helpers/loading_indicators.dart';
import 'package:flutter/material.dart';


class CircularLoader extends StatelessWidget {
  final double? height;
  final double? width;
  const CircularLoader({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 45,
        width: width ?? 45,
        child: loadingIndicatorCircle(
          context: context,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
