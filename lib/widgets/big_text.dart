import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  TextOverflow overflow;

  BigText({
    Key? key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
