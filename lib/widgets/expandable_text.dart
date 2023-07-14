import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/small_text.dart';

class ExpandedText extends StatefulWidget {
  final String text;
  const ExpandedText({required this.text, Key? key}) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 6.68;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (secondHalf == "")
          ? SmallText(
              text: widget.text,
              size: Dimensions.font16,
              color: AppColors.paraColor,
              height: 1.8,
            )
          : Column(
              children: [
                SmallText(
                  height: 1.8,
                  text: hiddenText == true
                      ? ("$firstHalf...")
                      : (firstHalf + secondHalf),
                  size: Dimensions.font16,
                  color: AppColors.paraColor,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText == true ? "Show more" : "Show less",
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText == true
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
