import 'package:enjin_wallet_daemon/main.dart';
import 'package:enjin_wallet_daemon/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../services/store_service.dart';

class OnboardScreen extends StatefulWidget {
  static const id = 'onboarding';

  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget _getPage(_, int index) {
      return switch (index) {
        0 => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'lib/assets/undraw_welcome.svg',
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Welcome to Enjin Platform',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'The best blockchain platform built for game developers',
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
        1 => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'lib/assets/undraw_synchronize.svg',
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'This application is a wallet daemon that connects to the platform\nallowing transactions to be signed automatically for you.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
        2 => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'lib/assets/undraw_secure.svg',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'To start you must first set a password. This will be used to encrypt your data.\nPlease note that this password cannot be recovered if lost. Not even by Enjin.',
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 48,
              ),
              SizedBox(
                width: 480,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    errorText: passwordController.text.length < 16 &&
                            passwordController.text != ''
                        ? 'Password must be at least 16 characters long'
                        : null,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: 'Input the password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF7567CE),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 480,
                child: TextField(
                  controller: repeatController,
                  obscureText: true,
                  onChanged: (text) => setState(() {}),
                  decoration: InputDecoration(
                    errorText: repeatController.text != '' &&
                            repeatController.text != passwordController.text
                        ? 'Passwords do not match'
                        : null,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: 'Repeat the password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF7567CE),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        _ => SvgPicture.asset('lib/assets/undraw_launch.svg'),
      };
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: 3,
              itemBuilder: (_, index) => _getPage(_, index),
            ),
          ),
          SizedBox(
            height: 30,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3, //pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 16,
                dotWidth: 16,
                activeDotColor: Color(0xFF7866D5),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 180,
            height: 48,
            child: MaterialButton(
              onPressed: currentPage == 2 &&
                      (passwordController.text != repeatController.text ||
                          passwordController.text.length < 16)
                  ? null
                  : () async {
                      if (currentPage == 2) {
                        if (passwordController.text != repeatController.text ||
                            passwordController.text.length < 16) {
                          return;
                        }

                        final store = getIt.get<StoreService>();
                        await store.init(passwordController.text);

                        Get.offNamed(MainScreen.id);

                        return;
                      }

                      setState(() {
                        currentPage++;
                      });

                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
              disabledColor: const Color(0xFF7866D5).withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFF7866D5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentPage == 2 ? "Confirm" : "Next",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
