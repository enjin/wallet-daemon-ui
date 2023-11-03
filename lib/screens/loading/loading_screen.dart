import 'package:enjin_wallet_daemon/screens/loading/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends GetView<LoadingController> {
  static const id = 'loading';

  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7567CE),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset('lib/assets/enjin_logo_white.svg'),
              LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 200,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
