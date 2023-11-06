import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'controller/lock_controller.dart';

// ignore_for_file: must_be_immutable
class LockScreen extends GetView<LockController> {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appTheme.blueGray900,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF7866D5), Color(0xFF5542B6)],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Opacity(
              opacity: 0.25,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF1E1E1E),
                      BlendMode.colorDodge,
                    ),
                    image: AssetImage(
                      'assets/images/lock_bg.png',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const Spacer(),
                  CustomImageView(
                    imagePath: 'assets/images/e_white.png',
                    width: 110,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'WALLET\nDAEMON',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'Genos',
                      fontWeight: FontWeight.w700,
                      height: 0.87,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: 380,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.passwordController,
                            obscureText: controller.isObscure,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Color(0xFF6D6D6D),
                              ),
                              contentPadding: EdgeInsets.only(left: 16),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your password to unlock',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: controller.checkPassword,
                          padding: const EdgeInsets.all(0),
                          icon: Icon(
                            Icons.arrow_circle_right,
                            size: 40,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CustomImageView(
                    imagePath: 'assets/images/poweredbyenjin.svg',
                    width: 110,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
