import 'package:flutter/Material.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  const IconAndText({
    required this.icon,
    required this.color,
    Key? key,
    required this.text,
    this.iconColor = const Color(0xFF89dad0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.width24,
        ),
        const SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
          color: color,
        ),
      ],
    );
  }
}
