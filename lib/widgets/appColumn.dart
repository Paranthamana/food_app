import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Header text
        BigText(text: text, size: Dimensions.font26),
        SizedBox(height: Dimensions.height10),
        //Comment section
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return const Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                );
              }),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: '4.5', color: AppColors.textColor),
            SizedBox(width: Dimensions.width10),
            SmallText(text: '123', color: AppColors.textColor),
            SizedBox(width: Dimensions.width10),
            SmallText(text: 'comments', color: AppColors.textColor),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7 K/m",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.access_time,
                text: "32 min",
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
