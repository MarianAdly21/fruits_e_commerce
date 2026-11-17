import 'package:flutter/material.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class DontHaveAccontCustomWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: RichText(
        text: TextSpan(
          text: "لا تمتلك حساب؟ ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.smallTextColor,
          ),
          children: [
            TextSpan(
              text: "قم بانشاء حساب",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
