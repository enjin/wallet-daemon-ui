import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:daemon/routes/app_pages.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/v4.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xterm/core.dart';
import 'package:xterm/ui.dart';
import 'package:flutter/material.dart';
import 'package:daemon/core/app_export.dart';
import '../../services/store_service.dart';
import 'controller/main_controller.dart';

// ignore_for_file: must_be_immutable
class MainScreen extends GetWidget<MainController> with WindowListener {
  MainScreen({super.key});

  Terminal terminal = Terminal();

  List<Widget> getText() {
    List<Widget> widgets = [];
    for (var i = 0; i < controller.output.length; i++) {
      widgets.insert(
        0,
        Text(
          controller.output[i],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return widgets;
  }

  Future<WidgetBuilder> get _showCustomPlatformDialog async {
    controller.platformEndpoint.value = await controller.store
            .record('enjin.custom.api.key')
            .get(StoreService.instance.db!) as String? ??
        '';

    controller.authToken.value = await controller.store
            .record('enjin.custom.api.url')
            .get(StoreService.instance.db!) as String? ??
        '';

    controller.rpcNode.value = await controller.store
            .record('enjin.custom.node.url')
            .get(StoreService.instance.db!) as String? ??
        '';

    TextEditingController platformEndpointController =
        TextEditingController(text: controller.platformEndpoint.value);
    TextEditingController platformAuthTokenController =
        TextEditingController(text: controller.authToken.value);
    TextEditingController platformRpcNodeController =
        TextEditingController(text: controller.rpcNode.value);

    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Container(
              width: 360,
              height: 306,
              padding: const EdgeInsets.all(23),
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
                    'Your platform endpoint',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: Obx(
                      () => TextField(
                        controller: platformEndpointController,
                        onChanged: (text) {
                          controller.platformEndpoint.value = text;
                        },
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          hintText: "Input the endpoint",
                          hintStyle: const TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: appTheme.deepPurple60001,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: appTheme.deepPurple60001,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFFFF5F57),
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color:
                                  controller.platformEndpoint.value.isNotEmpty
                                      ? const Color(0xFFF6F6F6)
                                      : const Color(0xFF303030),
                              style: BorderStyle.solid,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Authentication Token',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: Obx(
                      () => TextField(
                        controller: platformAuthTokenController,
                        onChanged: (text) {
                          controller.authToken.value = text;
                        },
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          hintText: "Input the authorization key",
                          hintStyle: const TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: appTheme.deepPurple60001,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: appTheme.deepPurple60001,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFFFF5F57),
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: controller.authToken.value.isNotEmpty
                                  ? const Color(0xFFF6F6F6)
                                  : const Color(0xFF303030),
                              style: BorderStyle.solid,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Blockchain RPC Node',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: Obx(
                      () => TextField(
                        controller: platformRpcNodeController,
                        onChanged: (text) {
                          controller.rpcNode.value = text;
                        },
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Input the RPC node',
                          hintStyle: const TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: appTheme.deepPurple60001,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: appTheme.deepPurple60001,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFFFF5F57),
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: controller.rpcNode.value.isNotEmpty
                                  ? const Color(0xFFF6F6F6)
                                  : const Color(0xFF303030),
                              style: BorderStyle.solid,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          await controller.setPlatformConfig(
                            controller.rpcNode.value,
                            controller.relayNode.value,
                            controller.platformEndpoint.value,
                            controller.authToken.value,
                          );
                          await controller.setCurrentNetwork('custom-endpoint');

                          Navigator.pop(context);
                        },
                        elevation: 0,
                        padding: const EdgeInsets.all(0),
                        color: Colors.transparent,
                        hoverElevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: 90,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: const Alignment(0.5, 0),
                              end: const Alignment(0.5, 1),
                              colors: [
                                appTheme.deepPurple400,
                                appTheme.deepPurple60001,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Apply',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        elevation: 0,
                        padding: const EdgeInsets.all(0),
                        color: Colors.transparent,
                        hoverElevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: 90,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    };
  }

  Future<void> showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Daemon Error'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You need to start the daemon at least one time'),
                Text('So it can generate a new wallet for you'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAlertViewSeed(BuildContext context) async {
    final TextEditingController passwordController = TextEditingController();

    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF4B4B4B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          titlePadding: const EdgeInsets.only(
            top: 48,
            left: 36,
          ),
          title: const Text(
            'Password Required',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0.03,
            ),
          ),
          contentPadding: const EdgeInsets.only(
            left: 36,
            right: 36,
            bottom: 28,
            top: 21,
          ),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  const Text(
                    'To view your seed phrase or wallet password. You need to input your Wallet Daemon UI password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: 380,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        hintText: 'Input your password',
                        hintStyle: const TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                ],
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.only(
            bottom: 28,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () async {
                    await StoreService.instance.close();
                    final bool hasAccess = await StoreService.instance
                        .init(passwordController.text);

                    if (!hasAccess) {
                      Get.offNamed(Routes.lock.nameToRoute());
                      return;
                    }

                    String? seed = await controller.getPlainSeed();
                    controller.walletSeed.text = seed!.replaceAll("\"", "");
                    controller.walletEditPassword.text =
                        controller.walletPassword;
                    controller.isSeedObscure.value = false;
                    controller.isPasswordObscure.value = false;

                    Navigator.of(context).pop();
                  },
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  color: Colors.transparent,
                  hoverElevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: const Alignment(0.5, 0),
                        end: const Alignment(0.5, 1),
                        colors: [
                          appTheme.deepPurple400,
                          appTheme.deepPurple60001,
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  color: Colors.transparent,
                  hoverElevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> showSetPasswordDialog(BuildContext context) async {
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
                height: 112,
                padding: const EdgeInsets.all(8),
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
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'generate a wallet for\nyour daemon',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                '. For extra security, we\'ll use a\npassword key to derive it. ',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Set your own\npassword ',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '(minimum of 8 characters)',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' or let\nus generate one for you',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: Color(0xFF4B4B4B),
                              fontSize: 12,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                  decoration: InputDecoration(
                    errorText: passwordController.text.length < 8 &&
                            passwordController.text != ''
                        ? 'Password must be at least 8 characters long'
                        : null,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: 'Input a password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF303030),
                    ),
                    errorStyle: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFFFF5F57),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: appTheme.deepPurple60001,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: appTheme.deepPurple60001,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF5F57),
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: passwordController.text.isNotEmpty
                            ? const Color(0xFFF6F6F6)
                            : const Color(0xFF303030),
                        style: BorderStyle.solid,
                        width: 0.5,
                      ),
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
                  controller: repeatController,
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                  decoration: InputDecoration(
                    errorText: repeatController.text.isNotEmpty &&
                            passwordController.text != repeatController.text
                        ? 'Passwords do not match'
                        : null,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: 'Input a password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF303030),
                    ),
                    errorStyle: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFFFF5F57),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: appTheme.deepPurple60001,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: appTheme.deepPurple60001,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF5F57),
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: repeatController.text.isNotEmpty
                            ? const Color(0xFFF6F6F6)
                            : const Color(0xFF303030),
                        style: BorderStyle.solid,
                        width: 0.5,
                      ),
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
                    onPressed: () async {
                      if (passwordController.text != repeatController.text ||
                          passwordController.text.length < 8) {
                        return;
                      }

                      await controller
                          .setWalletPassword(passwordController.text);
                      Navigator.pop(context);

                      await controller.runWallet();
                    },
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    color: Colors.transparent,
                    hoverElevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: 150,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: const Alignment(0.5, 0),
                          end: const Alignment(0.5, 1),
                          colors: [
                            appTheme.deepPurple400,
                            appTheme.deepPurple60001,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await controller.randomWalletPassword();
                      Navigator.of(context).pop();
                      await controller.runWallet();
                    },
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    color: Colors.transparent,
                    hoverElevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: 150,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          'Generate password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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

  Future<WidgetBuilder> get _localDialogBuilder async {
    controller.enjinMatrixKey.value = await controller.store
            .record('enjin.matrix.api.key')
            .get(StoreService.instance.db!) as String? ??
        '';
    controller.canaryMatrixKey.value = await controller.store
            .record('enjin.canary.api.key')
            .get(StoreService.instance.db!) as String? ??
        '';

    final TextEditingController enjinMatrixKey =
        TextEditingController(text: controller.enjinMatrixKey.value);
    final TextEditingController canaryMatrixKey =
        TextEditingController(text: controller.canaryMatrixKey.value);

    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 310,
            height: 425,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 19),
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
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: Obx(
                    () => TextField(
                      controller: enjinMatrixKey,
                      onChanged: (text) {
                        controller.enjinMatrixKey.value = text;
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        hintText: "Input your platform key",
                        hintStyle: const TextStyle(
                          color: Color(0xFF303030),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF5F57),
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: controller.enjinMatrixKey.value.isNotEmpty
                                ? const Color(0xFFF6F6F6)
                                : const Color(0xFF303030),
                            style: BorderStyle.solid,
                            width: 0.5,
                          ),
                        ),
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
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: Obx(
                    () => TextField(
                      controller: canaryMatrixKey,
                      onChanged: (text) {
                        controller.canaryMatrixKey.value = text;
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        hintText: "Input your platform key",
                        hintStyle: const TextStyle(
                          color: Color(0xFF303030),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF5F57),
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: controller.canaryMatrixKey.value.isNotEmpty
                                ? const Color(0xFFF6F6F6)
                                : const Color(0xFF303030),
                            style: BorderStyle.solid,
                            width: 0.5,
                          ),
                        ),
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
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: Obx(
                    () => TextField(
                      obscureText: controller.isSeedObscure.value,
                      readOnly: true,
                      controller: controller.walletSeed,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 26,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (controller.isSeedObscure.value == true) {
                              bool seedExists = await controller.store
                                  .record('enjin.daemon.seed')
                                  .exists(StoreService.instance.db!);

                              if (!seedExists) {
                                await showAlert(context);
                                return;
                              }

                              await showAlertViewSeed(context);
                            } else {
                              controller.walletSeed.text =
                                  (const UuidV4()).generate();
                              controller.isSeedObscure.value = true;
                            }
                          },
                          icon: controller.isSeedObscure.value
                              ? Image.asset('assets/images/eye.png')
                              : Image.asset('assets/images/eye_cut.png'),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF5F57),
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: controller.rpcNode.value.isNotEmpty
                                ? const Color(0xFFF6F6F6)
                                : const Color(0xFF303030),
                            style: BorderStyle.solid,
                            width: 0.5,
                          ),
                        ),
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
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: Obx(
                    () => TextField(
                      obscureText: controller.isPasswordObscure.value,
                      readOnly: true,
                      controller: controller.walletEditPassword,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        suffixIconConstraints: const BoxConstraints(
                          maxHeight: 26,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (controller.isPasswordObscure.value == true) {
                              if (controller.walletPassword == '') {
                                await showAlert(context);
                                return;
                              }

                              await showAlertViewSeed(context);
                            } else {
                              controller.walletEditPassword.text =
                                  (const UuidV4()).generate();
                              controller.isPasswordObscure.value = true;
                            }
                          },
                          icon: controller.isPasswordObscure.value
                              ? Image.asset('assets/images/eye.png')
                              : Image.asset('assets/images/eye_cut.png'),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: appTheme.deepPurple60001,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF5F57),
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: controller.rpcNode.value.isNotEmpty
                                ? const Color(0xFFF6F6F6)
                                : const Color(0xFF303030),
                            style: BorderStyle.solid,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        await controller.setDefaultAuthKeys(
                          enjinMatrixKey.text,
                          canaryMatrixKey.text,
                        );

                        Navigator.of(context).pop();
                      },
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      color: Colors.transparent,
                      hoverElevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 90,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: const Alignment(0.5, 0),
                            end: const Alignment(0.5, 1),
                            colors: [
                              appTheme.deepPurple400,
                              appTheme.deepPurple60001,
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Apply',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      color: Colors.transparent,
                      hoverElevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 90,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  width: 550,
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
                      Obx(
                        () => CustomImageView(
                          imagePath:
                              controller.currentNetwork.value == 'canary-matrix'
                                  ? ImageConstant.imgEnjinmatrixchaincanary
                                  : 'assets/images/img_enjinmatrix.png',
                          height: 37,
                          width: 37,
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              controller.isRunning.value
                                  ? 'Wallet Address (Running)'
                                  : controller.address.value.isEmpty
                                      ? 'Wallet Address (None)'
                                      : 'Wallet Address (Paused)',
                              style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 12,
                            width: 440,
                            child: TextField(
                              controller: controller.walletAddress,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.all(0),
                              ),
                              style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Obx(
                        () => Container(
                          width: 24,
                          decoration: BoxDecoration(
                            color: controller.isRunning.value
                                ? const Color(0xFF7DF17B)
                                : controller.address.value.isEmpty
                                    ? const Color(0xFF484848)
                                    : const Color(0xFFF17B7B),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Obx(
                  () => SizedBox(
                    height: 64,
                    width: 260,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        onHover: (hover) {
                          if (hover) {
                            controller.hoverAnimateController.forward();
                          } else {
                            controller.hoverAnimateController.reverse();
                          }
                        },
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onHover: (hover) {
                                if (hover) {
                                  controller.hoveredIcon.value = 'play';
                                  controller.playAnimateController.forward();
                                } else {
                                  controller.hoveredIcon.value = '';
                                  controller.playAnimateController.reverse();
                                }
                              },
                              onTap: () async {
                                if (controller.walletPassword.isEmpty) {
                                  await showSetPasswordDialog(context);
                                } else {
                                  await controller.runWallet();
                                }
                              },
                              child: SizedBox(
                                width: 65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                      size: 24,
                                      color: controller.isRunning.value == true
                                          ? Colors.white
                                          : controller.hoveredIcon.value ==
                                                  'play'
                                              ? const Color(0xFFB8B8B8)
                                              : const Color(0xFF6D6D6D),
                                    )
                                        .animate(
                                          autoPlay: false,
                                          controller:
                                              controller.playAnimateController,
                                        )
                                        .scale(
                                          begin: const Offset(1, 1),
                                          end: const Offset(1.3, 1.3),
                                          duration:
                                              const Duration(milliseconds: 100),
                                        ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Run',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: controller.isRunning.value ==
                                                true
                                            ? Colors.white
                                            : controller.hoveredIcon.value ==
                                                    'play'
                                                ? const Color(0xFFB8B8B8)
                                                : const Color(0xFF6D6D6D),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 6,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    )
                                        .animate(
                                          autoPlay: false,
                                          controller:
                                              controller.hoverAnimateController,
                                        )
                                        .fade(
                                          begin: 0.0,
                                          end: 1.0,
                                          duration:
                                              const Duration(milliseconds: 150),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onHover: (hover) {
                                if (hover) {
                                  controller.hoveredIcon.value = 'pause';
                                  controller.pauseAnimateController.forward();
                                } else {
                                  controller.hoveredIcon.value = '';
                                  controller.pauseAnimateController.reverse();
                                }
                              },
                              onTap: () async {
                                await controller.stopWallet();
                              },
                              child: SizedBox(
                                width: 65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.pause,
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                      size: 24,
                                      color: controller.hoveredIcon.value ==
                                              'pause'
                                          ? const Color(0xFFB8B8B8)
                                          : const Color(0xFF6D6D6D),
                                    )
                                        .animate(
                                          autoPlay: false,
                                          controller:
                                              controller.pauseAnimateController,
                                        )
                                        .scale(
                                          begin: const Offset(1, 1),
                                          end: const Offset(1.3, 1.3),
                                          duration:
                                              const Duration(milliseconds: 100),
                                        ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Pause',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: controller.hoveredIcon.value ==
                                                'pause'
                                            ? const Color(0xFFB8B8B8)
                                            : const Color(0xFF6D6D6D),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 6,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    )
                                        .animate(
                                          autoPlay: false,
                                          controller:
                                              controller.hoverAnimateController,
                                        )
                                        .fade(
                                          begin: 0.0,
                                          end: 1.0,
                                          duration:
                                              const Duration(milliseconds: 150),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onHover: (hover) {
                                if (hover) {
                                  controller.hoveredIcon.value = 'lock';
                                  controller.lockAnimateController.forward();
                                } else {
                                  controller.hoveredIcon.value = '';
                                  controller.lockAnimateController.reverse();
                                }
                              },
                              onTap: controller.lockScreen,
                              child: SizedBox(
                                width: 65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                      size: 24,
                                      color:
                                          controller.hoveredIcon.value == 'lock'
                                              ? const Color(0xFFB8B8B8)
                                              : const Color(0xFF6D6D6D),
                                    )
                                        .animate(
                                          autoPlay: false,
                                          controller:
                                              controller.lockAnimateController,
                                        )
                                        .scale(
                                          begin: const Offset(1, 1),
                                          end: const Offset(1.3, 1.3),
                                          duration:
                                              const Duration(milliseconds: 100),
                                        ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Lock',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: controller.hoveredIcon.value ==
                                                'lock'
                                            ? const Color(0xFFB8B8B8)
                                            : const Color(0xFF6D6D6D),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 6,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    )
                                        .animate(
                                          autoPlay: false,
                                          controller:
                                              controller.hoverAnimateController,
                                        )
                                        .fade(
                                          begin: 0.0,
                                          end: 1.0,
                                          duration:
                                              const Duration(milliseconds: 150),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                return InkWell(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onHover: (hover) {
                                    if (hover) {
                                      controller.hoveredIcon.value = 'settings';
                                      controller.settingsAnimateController
                                          .forward();
                                    } else {
                                      controller.hoveredIcon.value = '';
                                      controller.settingsAnimateController
                                          .reverse();
                                    }
                                  },
                                  onTap: () async {
                                    controller.isSettingsOpened.value = true;

                                    await showAlignedDialog(
                                      context: context,
                                      builder: await _localDialogBuilder,
                                      followerAnchor: Alignment.topLeft,
                                      targetAnchor: Alignment.bottomLeft,
                                      barrierColor: Colors.black54,
                                      offset: const Offset(-50, 0),
                                    );

                                    controller.isSettingsOpened.value = false;
                                  },
                                  child: SizedBox(
                                    width: 65,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(
                                          () => Icon(
                                            Icons.settings,
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 6,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              )
                                            ],
                                            size: 24,
                                            color: controller
                                                    .isSettingsOpened.value
                                                ? Colors.white
                                                : controller.hoveredIcon
                                                            .value ==
                                                        'settings'
                                                    ? const Color(0xFFB8B8B8)
                                                    : const Color(0xFF6D6D6D),
                                          )
                                              .animate(
                                                autoPlay: false,
                                                controller: controller
                                                    .settingsAnimateController,
                                              )
                                              .scale(
                                                begin: const Offset(1, 1),
                                                end: const Offset(1.3, 1.3),
                                                duration: const Duration(
                                                    milliseconds: 100),
                                              ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          'Settings',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                controller.hoveredIcon.value ==
                                                        'settings'
                                                    ? const Color(0xFFB8B8B8)
                                                    : const Color(0xFF6D6D6D),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 6,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                        )
                                            .animate(
                                              autoPlay: false,
                                              controller: controller
                                                  .hoverAnimateController,
                                            )
                                            .fade(
                                              begin: 0.0,
                                              end: 1.0,
                                              duration: const Duration(
                                                  milliseconds: 150),
                                            ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
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
            Builder(builder: (context) {
              return Container(
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
                child: Obx(
                  () => DropdownButton(
                    value: controller.currentNetwork.value,
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
                    onChanged: (String? value) async {
                      if (value == 'custom-endpoint') {
                        await showAlignedDialog(
                          context: context,
                          builder: await _showCustomPlatformDialog,
                          followerAnchor: Alignment.topLeft,
                          targetAnchor: Alignment.bottomLeft,
                          barrierColor: Colors.black54,
                        );

                        return;
                      }

                      String api = value == 'enjin-matrix'
                          ? 'https://platform.enjin.io/graphql'
                          : 'https://platform.canary.enjin.io/graphql';
                      String node = value == 'enjin-matrix'
                          ? 'wss://rpc.matrix.blockchain.enjin.io:443'
                          : 'wss://rpc.matrix.canary.enjin.io:443';
                      String relayNode = value == 'enjin-matrix'
                          ? 'wss://rpc.relay.blockchain.enjin.io:443'
                          : 'wss://rpc.relay.canary.enjin.io:443';

                      await controller.setDaemonConfigFile(
                          api, node, relayNode);
                      await controller.setCurrentNetwork(value!);
                      await controller.stopWallet();
                    },
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: TerminalView(
                controller.terminal,
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
