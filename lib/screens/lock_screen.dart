import 'package:beamer/beamer.dart';
import 'package:enjin_wallet_daemon/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:window_manager/window_manager.dart';
import '../services/daemon_service.dart';
import '../services/store_service.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> with WindowListener {
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() {
    getIt.get<DaemonService>().stopWallet();
  }

  Future<void> checkPassword() async {
    final bool hasAccess =
        await getIt.get<StoreService>().init(_passwordController.text);

    if (hasAccess) {
      Beamer.of(context).beamToReplacementNamed('/main', data: 'from_lock');
    }

    setState(() {
      _hasError = true;
    });
  }

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
              Lottie.asset('lib/assets/enjin-coin.json'),
              Container(
                width: 420,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 32, bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter Password',
                      style: TextStyle(
                        color: Color(0xFF434A60),
                        fontSize: 12,
                        fontFamily: 'Hauora',
                        fontWeight: FontWeight.w600,
                        height: 0.11,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      onChanged: (text) {
                        setState(() {
                          _hasError = false;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Hauora',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        errorText: _hasError ? 'Invalid Password' : null,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFF7567CE),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: MaterialButton(
                          minWidth: 0,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Icon(
                            _isObscure
                                ? Icons.remove_red_eye_outlined
                                : Icons.close,
                            size: 18,
                            color: const Color(0xFF2A2B56),
                          ),
                        ),
                        hintText: 'Your Password',
                        hintStyle: const TextStyle(
                          color: Color(0xFF858997),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      onPressed: () => checkPassword(),
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: const Color(0xFF7866D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Unlock Daemon",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
