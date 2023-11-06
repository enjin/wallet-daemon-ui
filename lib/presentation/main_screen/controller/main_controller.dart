import 'dart:convert';
import 'dart:io';

import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sembast/sembast.dart';
import 'package:uuid/v4.dart';
import 'package:xterm/core.dart';
import 'package:xterm/ui.dart';

import '../../../main.dart';
import '../../../routes/app_pages.dart';
import '../../../services/daemon_service.dart';
import '../../../services/store_service.dart';
import '../../lock_screen/controller/lock_controller.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();

  final isHovering = false.obs;
  final hoveredIcon = ''.obs;

  Terminal terminal = Terminal();
  TerminalController terminalController = TerminalController();

  final TextEditingController walletSeed =
      TextEditingController(text: const UuidV4().generate());
  final TextEditingController walletEditPassword =
      TextEditingController(text: const UuidV4().generate());
  final TextEditingController walletAddress = TextEditingController();

  final FocusNode selectNetwork = FocusNode();

  final StoreRef store = StoreRef.main();

  String currentNetwork = 'enjin-matrix';
  String walletPassword = '';

  bool hasAddress = false;
  bool isSeedObscure = true;
  bool isPasswordObscure = true;

  bool isRunning = false;

  List<String> output = [];

  void lockScreen() {
    Get.offNamed(Routes.lock.nameToRoute());
  }

//   Future<void> lockScreen() async {
//     await getIt.get<StoreService>().close();
//     Get.offNamed(LockScreen.id);
//   }
//

//
//   @override
//   void initState() {
//     super.initState();
//     windowManager.addListener(this);
//     loadData();
//   }
//
//   @override
//   void dispose() {
//     windowManager.removeListener(this);
//     super.dispose();
//   }
//
//   @override
//   void onWindowClose() {
//     getIt.get<DaemonService>().stopWallet();
//   }

//   Future<void> _showLockScreen(BuildContext context) async {
//     // bool hasPassword =
//     //     await secureStorage.containsKey(key: 'enjin.lock.password');
//
//     // if (hasPassword) {
//     //   await store.record('enjin.is_locked', value: 'true');
//     //
//     //   Beamer.of(context).beamToNamed('/lock');
//     // } else {
//     await _showSetPasswordDialog(context);
//     // }
//   }

  Future<void> setDaemonConfigFile(String api, String node) async {
    final config = {
      "node": node,
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
        .put(getIt.get<StoreService>().db!, seed);
    await store
        .record('enjin.daemon.store')
        .put(getIt.get<StoreService>().db!, storeName);
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

  void addToOutput(dynamic otp) async {
    if (!getIt.get<DaemonService>().hasAddress) {
      final search = [...otp.split('\n'), ...otp.split(' ')];
      for (String word in search) {
        final prefix = currentNetwork == 'enjin-matrix' ? 'ef' : 'cx';
        if (word.startsWith(prefix)) {
          String address = word.split('\n')[0];

          getIt.get<DaemonService>().address = address;
          walletEditPassword.text = address;
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
        .get(getIt.get<StoreService>().db!) as String?;
  }

  Future<bool> loadSeed() async {
    final String? seed = await store
        .record('enjin.daemon.seed')
        .get(getIt.get<StoreService>().db!) as String?;

    final String? storeFile = await store
        .record('enjin.daemon.store')
        .get(getIt.get<StoreService>().db!) as String?;

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
    isRunning = getIt.get<DaemonService>().isRunning;
  }

  Future<void> runWallet() async {
    if (walletPassword == '') {
      // await setupStart();
    }

    if (isRunning) {
      return;
    }

    String platformKey = '';

    if (currentNetwork == 'enjin-matrix') {
      platformKey = await store
              .record('enjin.matrix.api.key')
              .get(getIt.get<StoreService>().db!) as String? ??
          '';
    } else if (currentNetwork == 'canary-matrix') {
      platformKey = await store
              .record('enjin.canary.api.key')
              .get(getIt.get<StoreService>().db!) as String? ??
          '';
    } else {
      platformKey = await store
              .record('enjin.custom.api.key')
              .get(getIt.get<StoreService>().db!) as String? ??
          '';
    }

    final directory = await getApplicationSupportDirectory();
    String workingDir = directory.path;
    String walletApp = '$workingDir/wallet';
    String configFile = '$workingDir/config.json';

    final hasSeed = await loadSeed();

    await getIt.get<DaemonService>().runWallet(
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
    if (isRunning) {
      getIt.get<DaemonService>().stopWallet();
      await deleteStoreDir();
    }

    checkIsRunning();
  }

  Future<void> setPlatformConfig(String node, String api, String token) async {
    await store
        .record('enjin.custom.api.key')
        .put(getIt.get<StoreService>().db!, token);
    await store
        .record('enjin.custom.api.url')
        .put(getIt.get<StoreService>().db!, api);
    await store
        .record('enjin.custom.node.url')
        .put(getIt.get<StoreService>().db!, node);

    await setDaemonConfigFile(api, node);
  }

  Future<void> setDefaultAuthKeys(String authEnjin, String authCanary) async {
    await store
        .record('enjin.matrix.api.key')
        .put(getIt.get<StoreService>().db!, authEnjin);
    await store
        .record('enjin.canary.api.key')
        .put(getIt.get<StoreService>().db!, authCanary);
  }

  Future<void> randomWalletPassword() async {
    final uuid = const UuidV4().generate();
    await setWalletPassword(uuid);
  }

  Future<void> setWalletPassword(String password) async {
    await store
        .record('enjin.wallet.password')
        .put(getIt.get<StoreService>().db!, password);
    walletPassword = password;
  }

  void loadData() async {
    final String? password = await store
        .record('enjin.wallet.password')
        .get(getIt.get<StoreService>().db!) as String?;
    final String? selectedNetwork = await store
        .record('enjin.current.platform')
        .get(getIt.get<StoreService>().db!) as String?;

    checkIsRunning();

    if (isRunning && getIt.get<DaemonService>().hasAddress) {
      walletEditPassword.text = getIt.get<DaemonService>().address!;
      getIt.get<DaemonService>().setCallback(addToOutput: addToOutput);
    }

    walletPassword = password ?? '';
    currentNetwork = selectedNetwork ?? 'enjin-matrix';
  }

  Future<void> setCurrentNetwork(String network) async {
    await store
        .record('enjin.current.platform')
        .put(getIt.get<StoreService>().db!, network);

    currentNetwork = network;
  }

  Future<void> writeLockPassword(String password) async {
    await store
        .record('enjin.lock.password')
        .put(getIt.get<StoreService>().db!, password);
  }

  // Rx<SixModel> sixModelObj = SixModel().obs;
  //
  // SelectionPopupModel? selectedDropDownValue;
  //
  // onSelected(dynamic value) {
  //   for (var element in sixModelObj.value.dropdownItemList.value) {
  //     element.isSelected = false;
  //     if (element.id == value.id) {
  //       element.isSelected = true;
  //     }
  //   }
  //   sixModelObj.value.dropdownItemList.refresh();
  // }
}

//
// class _MainScreenState extends State<MainScreen> with  {

//
