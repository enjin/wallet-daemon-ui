import 'dart:convert';
import 'dart:io';

import 'package:daemon/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sembast/sembast.dart';
import 'package:uuid/v4.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xterm/core.dart';
import 'package:xterm/ui.dart';

import '../../../routes/app_pages.dart';
import '../../../services/daemon_service.dart';
import '../../../services/store_service.dart';

class MainController extends GetxController
    with GetTickerProviderStateMixin, WindowListener {
  static MainController get to => Get.find();

  final currentNetwork = 'enjin-matrix'.obs;
  final hoveredIcon = ''.obs;
  final isSeedObscure = true.obs;
  final isPasswordObscure = true.obs;
  final isRunning = false.obs;
  final isSettingsOpened = false.obs;

  late AnimationController hoverAnimateController;
  late AnimationController playAnimateController;
  late AnimationController pauseAnimateController;
  late AnimationController lockAnimateController;
  late AnimationController settingsAnimateController;

  final platformEndpoint = ''.obs;
  final authToken = ''.obs;
  final rpcNode = ''.obs;
  final relayNode = ''.obs;

  final enjinMatrixKey = ''.obs;
  final canaryMatrixKey = ''.obs;

  @override
  void onInit() {
    super.onInit();

    hoverAnimateController = AnimationController(vsync: this);
    playAnimateController = AnimationController(vsync: this);
    pauseAnimateController = AnimationController(vsync: this);
    lockAnimateController = AnimationController(vsync: this);
    settingsAnimateController = AnimationController(vsync: this);

    windowManager.addListener(this);
    loadData();
  }

  @override
  void onClose() {
    windowManager.removeListener(this);
    super.onClose();
  }

  @override
  void onWindowClose() {
    DaemonService.instance.stopWallet();
  }

  Terminal terminal = Terminal();
  TerminalController terminalController = TerminalController();

  final TextEditingController walletSeed =
      TextEditingController(text: const UuidV4().generate());
  final TextEditingController walletEditPassword =
      TextEditingController(text: const UuidV4().generate());
  final TextEditingController walletAddress = TextEditingController();

  final FocusNode selectNetwork = FocusNode();

  final StoreRef store = StoreRef.main();

  String walletPassword = '';
  bool hasAddress = false;

  List<String> output = [];

  void lockScreen() {
    Get.offNamed(Routes.lock.nameToRoute());
  }

  Future<void> setDaemonConfigFile(
      String api, String node, String relayNode) async {
    final config = {
      "node": node,
      "relay_node": relayNode,
      "api": api,
      "master_key": "store",
    };

    final configJson = jsonEncode(config);

    final directory = await getApplicationSupportDirectory();
    File(p.join(directory.path, 'config.json')).writeAsStringSync(configJson);

    walletEditPassword.text = '';
  }

  Future<void> saveSeed(String seed, String storeName) async {
    await store
        .record('enjin.daemon.seed')
        .put(StoreService.instance.db!, seed);
    await store
        .record('enjin.daemon.store')
        .put(StoreService.instance.db!, storeName);
  }

  Future<void> saveStoreFile() async {
    final dir = await getApplicationSupportDirectory();
    final storeDir = Directory(p.join(dir.path, 'store'));
    final List<FileSystemEntity> files = storeDir.listSync();

    for (var store in files) {
      String storeName = p.basename(store.path);
      String seedPhrase = File(store.path).readAsStringSync();

      await saveSeed(seedPhrase, storeName);
    }
  }

  final address = ''.obs;

  void addToOutput(dynamic otp) async {
    if (!DaemonService.instance.hasAddress) {
      final search = [...otp.split('\n'), ...otp.split(' ')];
      for (String word in search) {
        final prefix = currentNetwork.value == 'enjin-matrix' ? 'ef' : 'cx';
        if (word.startsWith(prefix)) {
          String addr = word.split('\n')[0];

          address.value = addr;
          walletAddress.text = addr;
          DaemonService.instance.address = addr;
          walletEditPassword.text = addr;
        }
      }

      await saveStoreFile();
      await deleteStoreDir();

      return;
    }

    terminal.write(otp.trim());
    terminal.nextLine();
    terminal.write('\n');
  }

  Future<String?> getPlainSeed() async {
    return await store
        .record('enjin.daemon.seed')
        .get(StoreService.instance.db!) as String?;
  }

  Future<bool> loadSeed() async {
    final String? seed = await store
        .record('enjin.daemon.seed')
        .get(StoreService.instance.db!) as String?;

    final String? storeFile = await store
        .record('enjin.daemon.store')
        .get(StoreService.instance.db!) as String?;

    if (seed != null && storeFile != null) {
      final dir = await getApplicationSupportDirectory();
      final storePath = p.join(dir.path, 'store');
      Directory(storePath).createSync(recursive: true);

      final file = File(p.join(storePath, storeFile));
      file.writeAsStringSync(seed);

      return true;
    }

    return false;
  }

  void checkIsRunning() {
    isRunning.value = DaemonService.instance.isRunning;
  }

  Future<void> runWallet() async {
    if (isRunning.value == true) {
      return;
    }

    String platformKey = '';

    if (currentNetwork.value == 'enjin-matrix') {
      platformKey = await store
              .record('enjin.matrix.api.key')
              .get(StoreService.instance.db!) as String? ??
          '';
    } else if (currentNetwork.value == 'canary-matrix') {
      platformKey = await store
              .record('enjin.canary.api.key')
              .get(StoreService.instance.db!) as String? ??
          '';
    } else {
      platformKey = await store
              .record('enjin.custom.api.key')
              .get(StoreService.instance.db!) as String? ??
          '';
    }

    final directory = await getApplicationSupportDirectory();
    String workingDir = directory.path;
    String walletApp = '$workingDir/wallet';
    String configFile = '$workingDir/config.json';

    final hasSeed = await loadSeed();

    await DaemonService.instance.runWallet(
      walletApp: walletApp,
      walletPassword: walletPassword,
      platformKey: platformKey,
      configFile: configFile,
      workingDir: workingDir,
      addToOutput: addToOutput,
    );

    checkIsRunning();
  }

  Future<void> deleteStoreDir() async {
    final directory = await getApplicationSupportDirectory();
    String path = p.join(directory.path, 'store');
    Directory dir = Directory(path);
    if (dir.existsSync()) {
      dir.delete(recursive: true);
    }
  }

  Future<void> stopWallet() async {
    if (isRunning.value == true) {
      DaemonService.instance.stopWallet();
      await deleteStoreDir();
    }

    checkIsRunning();
  }

  Future<void> setPlatformConfig(
      String node, String relayNode, String api, String token) async {
    await store
        .record('enjin.custom.api.key')
        .put(StoreService.instance.db!, token);
    await store
        .record('enjin.custom.api.url')
        .put(StoreService.instance.db!, api);
    await store
        .record('enjin.custom.node.url')
        .put(StoreService.instance.db!, node);
    await store
        .record('enjin.custom.relay.url')
        .put(StoreService.instance.db!, relayNode);

    await setDaemonConfigFile(api, node, relayNode);
  }

  Future<void> setDefaultAuthKeys(String authEnjin, String authCanary) async {
    await store
        .record('enjin.matrix.api.key')
        .put(StoreService.instance.db!, authEnjin);
    await store
        .record('enjin.canary.api.key')
        .put(StoreService.instance.db!, authCanary);
  }

  Future<void> randomWalletPassword() async {
    final uuid = const UuidV4().generate();
    await setWalletPassword(uuid);
  }

  Future<void> setWalletPassword(String password) async {
    await store
        .record('enjin.wallet.password')
        .put(StoreService.instance.db!, password);
    walletPassword = password;
  }

  void loadData() async {
    final String? password = await store
        .record('enjin.wallet.password')
        .get(StoreService.instance.db!) as String?;
    final String? selectedNetwork = await store
        .record('enjin.current.platform')
        .get(StoreService.instance.db!) as String?;

    checkIsRunning();

    if (isRunning.value == true && DaemonService.instance.hasAddress) {
      String addr = DaemonService.instance.address!;
      walletEditPassword.text = addr;
      address.value = addr;
      DaemonService.instance.setCallback(addToOutput: addToOutput);
    }

    walletPassword = password ?? '';
    currentNetwork.value = selectedNetwork ?? 'enjin-matrix';
  }

  Future<void> setCurrentNetwork(String network) async {
    await store
        .record('enjin.current.platform')
        .put(StoreService.instance.db!, network);

    currentNetwork.value = network;
  }

  Future<void> writeLockPassword(String password) async {
    await store
        .record('enjin.lock.password')
        .put(StoreService.instance.db!, password);
  }
}
