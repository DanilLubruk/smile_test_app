import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringPlaceholder extends StatelessWidget {
  final double height;
  final double width;

  const ShimmeringPlaceholder(
      {required this.height, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10))));
}
