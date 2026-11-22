import 'package:flutter/widgets.dart';
import 'package:fruits_e_commerce/res/app_color.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomProgressHud extends StatelessWidget {
  const new({super.key, required this.child, required this.isLoading});
  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: AppColor.primaryColor,
      child: child,
    );
  }
}
