import 'package:flutter/material.dart';
import 'package:fruits_e_commerce/features/on_bording/presentation/views/widgets/page_view_item.dart';
import 'package:fruits_e_commerce/res/app_assets.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class OnBordingPageView extends StatelessWidget {
  const new({super.key, required this.controller});
  final PageController controller;
  //final int currentPage;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        PageViewItem(
          backgroundImage: AppAssets.viewBageItem1Bg,
          image: AppAssets.viewBageItem1,
          isVisible: true,
          subTitle: "اكتشف تجربة تسوق فريدة مع FruitHUB. استكشف مجموعتنا الواسعة من الفواكه الطازجة الممتازة واحصل على أفضل العروض والجودة العالية.",
          title: RichText(
            text: TextSpan(
              text: "مرحبًا بك في ",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColor.blackFont,
              ),
              children: [
                TextSpan(
                  text: "Fruit",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                TextSpan(
                  text: "HUB",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        PageViewItem(
          image: AppAssets.viewBageItem2,
          backgroundImage: AppAssets.viewBageItem2Bg,
          isVisible: false,
          subTitle: "نقدم لك أفضل الفواكه المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار الفاكهة المثالية",
          title: Text(
            "ابحث وتسوق",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColor.blackFont,
            ),
          ),
        ),
      ],
    );
  }
}
