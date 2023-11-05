import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:xterm/core.dart';
import 'package:xterm/ui.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import '../../routes/app_pages.dart';
import 'controller/main_controller.dart';

// ignore_for_file: must_be_immutable
class MainScreen extends GetWidget<MainController> {
  MainScreen({super.key});

  Terminal terminal = Terminal();

  Future<void> _showSetPasswordDialog(BuildContext context) async {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => SimpleDialog(
            backgroundColor: const Color(0xFF494949),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Wallet Creation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            contentPadding:
                const EdgeInsets.only(left: 36, right: 36, bottom: 28, top: 20),
            children: <Widget>[
              Container(
                width: 345,
                height: 104,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: 'assets/images/warning.svg',
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Before using, you must ',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 10,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'generate a wallet for\nyour daemon',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 10,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                '. For extra security, we\'ll use a\npassword key to derive it. ',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 10,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Set your own\npassword ',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 10,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '(minimum of 8 characters)',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' or let\nus generate one for you',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 10,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 10,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Your password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0.13,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 330,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    errorText: passwordController.text.length < 8 &&
                            passwordController.text != ''
                        ? 'Password must be at least 8 characters long'
                        : null,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: 'Input a password',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              const Text(
                'Repeat your password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0.13,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 330,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    errorText: passwordController.text.length < 8 &&
                            passwordController.text != ''
                        ? 'Password must be at least 8 characters long'
                        : null,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: 'Input a password',
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    color: const Color(0xFF7866D5),
                    // gradient: const LinearGradient(
                    //   begin: Alignment(0.00, -1.00),
                    //   end: Alignment(0, 1),
                    //   colors: [
                    //     Color(0xFF7866D5),
                    //     Color(0xFF5543B7),
                    //   ],
                    // ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Generate password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  WidgetBuilder get _localDialogBuilder {
    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          print('test');
          Navigator.of(context).pop();
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 257,
            height: 395,
            padding: const EdgeInsets.all(29),
            decoration: ShapeDecoration(
              color: const Color(0xFF494949),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.27),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 3.76,
                  offset: Offset(0, 2.51),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enjin Matrixchain',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 26,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Input your platform key",
                      hintStyle: const TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Canary Matrixchain',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 26,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Input your platform key",
                      hintStyle: const TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Generated Wallet Seed Phrase\n(read-only)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 26,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Input your platform key",
                      hintStyle: const TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Generated Wallet Password\n(read-only)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 26,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Input your platform key",
                      hintStyle: const TextStyle(
                        color: Color(0xFF2F2F2F),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: appTheme.blueGray900,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 64,
                  width: 506,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF6C6C6C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgEnjinmatrixchaincanary,
                        height: 37,
                        width: 37,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "msg_wallet_address_paused".tr,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "msg_efrrzmui6vmnqmx".tr,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 24,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF17B7B),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _showSetPasswordDialog(context);
                  },
                  padding: const EdgeInsets.all(0),
                  hoverColor: const Color(0xFFB8B8B8),
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Color(0xFF6D6D6D),
                    size: 24,
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                IconButton(
                  onPressed: () {
                    Get.offNamed(Routes.lock.nameToRoute());
                  },
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.pause,
                    color: Color(0xFF6D6D6D),
                    size: 24,
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.lock,
                    color: Color(0xFF6D6D6D),
                    size: 24,
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      showAlignedDialog(
                        context: context,
                        builder: _localDialogBuilder,
                        followerAnchor: Alignment.topLeft,
                        targetAnchor: Alignment.bottomLeft,
                      );
                    },
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(
                      Icons.settings,
                      color: Color(0xFF6D6D6D),
                      size: 24,
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  width: 45,
                ),
                Container(
                  width: 165,
                  height: 40,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        Color(0xFF7866D5),
                        Color(0xFF5543B7),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: 'assets/images/Subtract.svg',
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text(
                        'Wallet Daemon',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Container(
              // height: 34,
              width: 220,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: ShapeDecoration(
                color: const Color(0xFF6C6C6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: DropdownButton(
                value: 'enjin-matrix',
                dropdownColor: const Color(0xFF6C6C6C),
                underline: const SizedBox(),
                iconEnabledColor: Colors.white,
                isExpanded: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'enjin-matrix',
                    child: Text('Enjin Platform Matrix'),
                  ),
                  DropdownMenuItem(
                    value: 'canary-matrix',
                    child: Text('Enjin Platform Canary'),
                  ),
                  DropdownMenuItem(
                    value: 'custom-endpoint',
                    child: Text('Custom Endpoint'),
                  ),
                ],
                onChanged: (String? value) {},
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: TerminalView(
                terminal,
                padding: const EdgeInsets.only(top: 10),
                readOnly: true,
                backgroundOpacity: 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
