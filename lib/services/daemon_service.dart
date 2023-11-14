import 'dart:async';
import 'dart:convert';
import 'dart:io';

class DaemonService {
  static final DaemonService _singleton = DaemonService._();
  static DaemonService get instance => _singleton;
  DaemonService._();

  Process? daemon;

  bool get isRunning => daemon != null;

  late StreamSubscription logStream;

  String? address;

  bool get hasAddress => address != null;

  void stopWallet() {
    if (daemon != null) {
      daemon!.kill();
    }

    address = null;
    daemon = null;
  }

  void setCallback({
    required void Function(dynamic) addToOutput,
  }) {
    logStream.onData(addToOutput);
  }

  Future<void> runWallet({
    required String walletApp,
    required String walletPassword,
    required String platformKey,
    required String configFile,
    required String workingDir,
    required void Function(dynamic) addToOutput,
  }) async {
    if (!Platform.isWindows) {
      await Process.run("chmod", ["+x", walletApp]);
    }

    daemon = await Process.start(
      walletApp,
      [],
      environment: {
        "KEY_PASS": walletPassword,
        "PLATFORM_KEY": platformKey,
        "CONFIG_FILE": configFile,
      },
      workingDirectory: workingDir,
    );

    logStream = daemon!.stdout.transform(utf8.decoder).listen(addToOutput);
  }
}
