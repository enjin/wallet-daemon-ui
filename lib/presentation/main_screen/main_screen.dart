import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/v4.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xterm/core.dart';
import 'package:xterm/ui.dart';
import 'package:flutter/material.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import '../../main.dart';
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

  Future<void> _showConfigDialog(BuildContext context) async {
    final String enjinKey = await controller.store
            .record('enjin.matrix.api.key')
            .get(getIt.get<StoreService>().db!) as String? ??
        '';
    final String canaryKey = await controller.store
            .record('enjin.canary.api.key')
            .get(getIt.get<StoreService>().db!) as String? ??
        '';

    final TextEditingController enjinMatrixKey =
        TextEditingController(text: enjinKey);
    final TextEditingController canaryMatrixKey =
        TextEditingController(text: canaryKey);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SimpleDialog(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enjin Platform - Configuration'),
                ],
              ),
              contentPadding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 10),
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Enjin Matrixchain',
                  style: TextStyle(
                    color: Color(0xFF434A60),
                    fontSize: 12,
                    fontFamily: 'Hauora',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 360,
                  height: 48,
                  child: TextField(
                    controller: enjinMatrixKey,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      hintText: 'Input your platform key',
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
                const Text(
                  'Canary Matrixchain',
                  style: TextStyle(
                    color: Color(0xFF434A60),
                    fontSize: 12,
                    fontFamily: 'Hauora',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 360,
                  height: 48,
                  child: TextField(
                    controller: canaryMatrixKey,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      hintText: 'Input your platform key',
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
                const Text(
                  'Generated wallet seed phrase (read-only)',
                  style: TextStyle(
                    color: Color(0xFF434A60),
                    fontSize: 12,
                    fontFamily: 'Hauora',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 360,
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          obscureText: controller.isSeedObscure,
                          controller: controller.walletSeed,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
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
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (controller.isSeedObscure == true) {
                            bool seedExists = await controller.store
                                .record('enjin.daemon.seed')
                                .exists(getIt.get<StoreService>().db!);

                            if (!seedExists) {
                              await showAlert(context);
                              return;
                            }

                            await showAlertViewSeed(context);
                            setState(() {});
                          } else {
                            setState(() {
                              controller.walletSeed.text =
                                  (const UuidV4()).generate();
                              controller.isSeedObscure = true;
                            });
                          }
                        },
                        elevation: 0,
                        color: const Color(0xFF7866D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.isSeedObscure ? "Show" : "Hide",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Generated wallet password (read-only)',
                  style: TextStyle(
                    color: Color(0xFF434A60),
                    fontSize: 12,
                    fontFamily: 'Hauora',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 360,
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          obscureText: controller.isPasswordObscure,
                          controller: controller.walletEditPassword,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
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
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (controller.isPasswordObscure == true) {
                            if (controller.walletPassword == '') {
                              showAlert(context);
                              return;
                            }

                            await showAlertViewSeed(context);
                            setState(() {});
                          } else {
                            setState(() {
                              controller.walletEditPassword.text =
                                  (const UuidV4()).generate();
                              controller.isPasswordObscure = true;
                            });
                          }
                        },
                        elevation: 0,
                        color: const Color(0xFF7866D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          controller.isPasswordObscure ? "Show" : "Hide",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        await controller
                            .setDefaultAuthKeys(
                              enjinMatrixKey.text,
                              canaryMatrixKey.text,
                            )
                            .then((value) => Navigator.pop(context));
                      },
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: const Color(0xFF7866D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(color: Colors.white),
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
                      color: const Color(0xFF7866D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showCustomPlatformDialog(BuildContext context) async {
    final String apiToken = await controller.store
            .record('enjin.custom.api.key')
            .get(getIt.get<StoreService>().db!) as String? ??
        '';
    final String apiUrl = await controller.store
            .record('enjin.custom.api.url')
            .get(getIt.get<StoreService>().db!) as String? ??
        '';
    final String nodeUrl = await controller.store
            .record('enjin.custom.node.url')
            .get(getIt.get<StoreService>().db!) as String? ??
        '';

    final TextEditingController platformEndpoint =
        TextEditingController(text: apiUrl);
    final TextEditingController authToken =
        TextEditingController(text: apiToken);
    final TextEditingController rpcNode = TextEditingController(text: nodeUrl);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Custom Platform - Configuration'),
            ],
          ),
          contentPadding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Your platform endpoint',
              style: TextStyle(
                color: Color(0xFF434A60),
                fontSize: 12,
                fontFamily: 'Hauora',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 360,
              height: 48,
              child: TextField(
                controller: platformEndpoint,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  hintText: 'https://myplatform.game.io/graphql',
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
            const Text(
              'Authentication token',
              style: TextStyle(
                color: Color(0xFF434A60),
                fontSize: 12,
                fontFamily: 'Hauora',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 380,
              height: 48,
              child: TextField(
                controller: authToken,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  hintText: 'Platform authentication token',
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
            const Text(
              'Blockchain RPC node',
              style: TextStyle(
                color: Color(0xFF434A60),
                fontSize: 12,
                fontFamily: 'Hauora',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 360,
              height: 48,
              child: TextField(
                controller: rpcNode,
                decoration: InputDecoration(
                  hintText: "wss://rpc.matrix.blockchain.enjin.io:443",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () async {
                    await controller.setPlatformConfig(
                      rpcNode.text,
                      platformEndpoint.text,
                      authToken.text,
                    );
                    await controller.setCurrentNetwork('custom-endpoint');

                    Navigator.pop(context);
                  },
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: const Color(0xFF7866D5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: const Color(0xFF7866D5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
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
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Required'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('To view your seed phrase or wallet password'),
                const Text('You need to input your Wallet Daemon UI password'),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 380,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    // onChanged: (text) => setState(() {}),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      hintText: 'Input your password',
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
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                await getIt.get<StoreService>().close();
                final bool hasAccess = await getIt
                    .get<StoreService>()
                    .init(passwordController.text);

                if (!hasAccess) {
                  // Get.offNamed(LockScreen.id);
                  return;
                }

                String? seed = await controller.getPlainSeed();
                controller.walletSeed.text = seed!.replaceAll("\"", "");
                controller.walletEditPassword.text = controller.walletPassword;
                controller.isSeedObscure = false;
                controller.isPasswordObscure = false;

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> setupStart(BuildContext context) async {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => SimpleDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wallet Password'),
              ],
            ),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            children: <Widget>[
              const Text(
                'To start we need to generate a wallet for your daemon.\nFor extra security, we use a password key to derive it.\nYou can set your own password or we can generate one for you.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Set your password',
                style: TextStyle(
                  color: Color(0xFF434A60),
                  fontSize: 12,
                  fontFamily: 'Hauora',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 360,
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
              const Text(
                'Repeat the password',
                style: TextStyle(
                  color: Color(0xFF434A60),
                  fontSize: 12,
                  fontFamily: 'Hauora',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 380,
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
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: passwordController.text.length < 8 ||
                            repeatController.text != passwordController.text
                        ? 0.5
                        : 1,
                    child: MaterialButton(
                      onPressed: () async {
                        if (passwordController.text == repeatController.text &&
                            passwordController.text.length >= 8) {
                          await controller
                              .setWalletPassword(passwordController.text);
                          Navigator.of(context).pop();
                        }
                      },
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: const Color(0xFF7866D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await controller.randomWalletPassword();
                      Navigator.pop(context);
                    },
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    color: const Color(0xFF7866D5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Auto-generate",
                      style: TextStyle(color: Colors.white),
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
                  style: TextStyle(
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
                    errorStyle: const TextStyle(
                      color: Color(0xFFFF5F57),
                    ),
                    errorBorder: OutlineInputBorder(
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
                    errorText: passwordController.text != repeatController.text
                        ? 'Passwords do not match'
                        : null,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: 'Input a password',
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
                    errorStyle: const TextStyle(
                      color: Color(0xFFFF5F57),
                    ),
                    errorBorder: OutlineInputBorder(
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
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (passwordController.text != repeatController.text ||
                          passwordController.text.length < 8) {
                        return;
                      }

                      controller.setWalletPassword(passwordController.text);
                      Navigator.pop(context);
                    },
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
                  onPressed: () {},
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
                  onPressed: controller.lockScreen,
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
//
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: controller.lockScreen,
//         backgroundColor: const Color(0xFF7866D5),
//         child: const Icon(
//           Icons.lock,
//           color: Colors.white,
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF7866D5),
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 30,
//               child: Image.asset('lib/assets/White.png'),
//             ),
//             const SizedBox(
//               width: 16,
//             ),
//             const Text(
//               'Wallet Daemon',
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 70,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 DropdownButton(
//                   value: controller.currentNetwork,
//                   focusNode: controller.selectNetwork,
//                   style: const TextStyle(
//                     color: Color(0xFF858997),
//                     fontSize: 15,
//                     fontFamily: 'Hauora',
//                     fontWeight: FontWeight.w800,
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'enjin-matrix',
//                       child: Text('Enjin Platform Matrix'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'canary-matrix',
//                       child: Text('Enjin Platform Canary'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'custom-endpoint',
//                       child: Text('Custom Endpoint'),
//                     ),
//                   ],
//                   onChanged: (String? value) {
//                     if (value == 'custom-endpoint') {
//                       // showCustomPlatformDialog();
//                       return;
//                     }
//                     controller.setCurrentNetwork(value!);
//                     controller.stopWallet();
//
//                     controller.selectNetwork.nextFocus();
//                   },
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 if (controller.walletAddress.text != '')
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Spacer(),
//                       RichText(
//                         text: TextSpan(
//                           text: 'Wallet Address ',
//                           style: const TextStyle(
//                             color: Color(0xFF434A60),
//                             fontSize: 12,
//                             fontFamily: 'Hauora',
//                             fontWeight: FontWeight.w600,
//                           ),
//                           children: [
//                             if (controller.isRunning)
//                               TextSpan(
//                                 text: '(running)',
//                                 style: TextStyle(
//                                   color: Colors.green[700],
//                                 ),
//                               )
//                             else
//                               TextSpan(
//                                 text: '(stopped)',
//                                 style: TextStyle(
//                                   color: Colors.red[700],
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       SizedBox(
//                         width: 420,
//                         child: TextField(
//                           readOnly: true,
//                           controller: controller.walletAddress,
//                           style: const TextStyle(
//                             color: Color(0xFF858997),
//                             fontSize: 13,
//                             fontFamily: 'Hauora',
//                             fontWeight: FontWeight.w400,
//                           ),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.all(0),
//                             border: InputBorder.none,
//                             isDense: true,
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//                 const Spacer(),
//                 Opacity(
//                   opacity: controller.isRunning ? 0.5 : 1,
//                   child: MaterialButton(
//                     focusNode: getIt.get<StoreService>().focusNode,
//                     onPressed: () => controller.runWallet(),
//                     height: 48,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     color: const Color(0xFF7866D5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "Start",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Opacity(
//                   opacity: controller.isRunning ? 1.0 : 0.5,
//                   child: MaterialButton(
//                     onPressed: () => controller.stopWallet(),
//                     height: 48,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     color: const Color(0xFF7866D5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "Stop",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 MaterialButton(
//                   onPressed: () async {
//                     await _showConfigDialog(context);
//                     // setState(() {
//                       controller.walletEditPassword.text = const UuidV4().generate();
//                       controller.walletSeed.text = const UuidV4().generate();
//                       controller.isPasswordObscure = true;
//                       controller.isSeedObscure = true;
//                     // });
//                   },
//                   height: 48,
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   color: const Color(0xFF7866D5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     "Configs",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TerminalView(
//               terminal,
//               padding: const EdgeInsets.only(top: 10),
//               readOnly: true,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
