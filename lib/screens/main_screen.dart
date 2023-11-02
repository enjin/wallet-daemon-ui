import 'package:beamer/beamer.dart';
import 'package:enjin_wallet_daemon/main.dart';
import 'package:enjin_wallet_daemon/services/daemon_service.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/v4.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xterm/xterm.dart';
import '../services/store_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WindowListener {
  Terminal terminal = Terminal();
  TerminalController terminalController = TerminalController();

  final TextEditingController _walletSeed =
      TextEditingController(text: const UuidV4().generate());
  final TextEditingController _walletPassword =
      TextEditingController(text: const UuidV4().generate());
  final TextEditingController _walletAddress = TextEditingController();

  final FocusNode _selectNetwork = FocusNode();

  final StoreRef store = StoreRef.main();
  final Database db = getIt.get<StoreService>().db;

  String currentNetwork = 'enjin-matrix';
  String walletPassword = '';

  bool hasAddress = false;
  bool _isSeedObscure = true;
  bool _isPasswordObscure = true;

  bool isRunning = false;

  List<String> output = [];

  Future<void> setDaemonConfigFile(String api, String node) async {
    final config = {
      "node": node,
      "api": api,
      "master_key": "store",
    };

    final configJson = jsonEncode(config);

    final directory = await getApplicationSupportDirectory();
    File(p.join(directory.path, 'config.json')).writeAsStringSync(configJson);

    setState(() {
      _walletAddress.text = '';
    });
  }

  Future<void> saveSeed(String seed, String storeName) async {
    await store.record('enjin.daemon.seed').put(db, seed);
    await store.record('enjin.daemon.store').put(db, storeName);
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

          setState(() {
            _walletAddress.text = address;
          });
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
    return await store.record('enjin.daemon.seed').get(db) as String?;
  }

  Future<bool> loadSeed() async {
    final String? seed =
        await store.record('enjin.daemon.seed').get(db) as String?;

    final String? storeFile =
        await store.record('enjin.daemon.store').get(db) as String?;

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
    setState(() {
      isRunning = getIt.get<DaemonService>().isRunning;
    });
  }

  Future<void> runWallet() async {
    if (walletPassword == '') {
      await setupStart();
    }

    if (isRunning) {
      return;
    }

    String platformKey = '';

    if (currentNetwork == 'enjin-matrix') {
      platformKey =
          await store.record('enjin.matrix.api.key').get(db) as String? ?? '';
    } else if (currentNetwork == 'canary-matrix') {
      platformKey =
          await store.record('enjin.canary.api.key').get(db) as String? ?? '';
    } else {
      platformKey =
          await store.record('enjin.custom.api.key').get(db) as String? ?? '';
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

  List<Widget> getText() {
    List<Widget> widgets = [];
    for (var i = 0; i < output.length; i++) {
      widgets.insert(
        0,
        Text(
          output[i],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return widgets;
  }

  Future<void> setPlatformConfig(String node, String api, String token) async {
    await store.record('enjin.custom.api.key').put(db, token);
    await store.record('enjin.custom.api.url').put(db, api);
    await store.record('enjin.custom.node.url').put(db, node);

    await setDaemonConfigFile(api, node);
  }

  Future<void> setDefaultAuthKeys(String authEnjin, String authCanary) async {
    await store.record('enjin.matrix.api.key').put(db, authEnjin);
    await store.record('enjin.canary.api.key').put(db, authCanary);
  }

  Future<void> _showConfigDialog(BuildContext context) async {
    final String enjinKey =
        await store.record('enjin.matrix.api.key').get(db) as String? ?? '';
    final String canaryKey =
        await store.record('enjin.canary.api.key').get(db) as String? ?? '';

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
                          obscureText: _isSeedObscure,
                          controller: _walletSeed,
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
                          if (_isSeedObscure == true) {
                            String? seed = await getPlainSeed();
                            if (seed == null) {
                              showAlert(context);
                              return;
                            }

                            _walletSeed.text = seed.replaceAll("\"", "");
                          } else {
                            _walletSeed.text = (const UuidV4()).generate();
                          }

                          setState(() {
                            _isSeedObscure = !_isSeedObscure;
                          });
                        },
                        elevation: 0,
                        color: const Color(0xFF7866D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _isSeedObscure ? "Show" : "Hide",
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
                          obscureText: _isPasswordObscure,
                          controller: _walletPassword,
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
                        onPressed: () {
                          if (_isPasswordObscure == true) {
                            _walletPassword.text = walletPassword;
                          } else {
                            _walletPassword.text = (const UuidV4()).generate();
                          }

                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                        elevation: 0,
                        color: const Color(0xFF7866D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _isPasswordObscure ? "Show" : "Hide",
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
                        await setDefaultAuthKeys(
                          enjinMatrixKey.text,
                          canaryMatrixKey.text,
                        ).then((value) => Navigator.pop(context));
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

  Future<void> _showCustomPlatformDialog() async {
    final String apiToken =
        await store.record('enjin.custom.api.key').get(db) as String? ?? '';
    final String apiUrl =
        await store.record('enjin.custom.api.url').get(db) as String? ?? '';
    final String nodeUrl =
        await store.record('enjin.custom.node.url').get(db) as String? ?? '';

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
                    await setPlatformConfig(
                      rpcNode.text,
                      platformEndpoint.text,
                      authToken.text,
                    );
                    await setCurrentNetwork('custom-endpoint');

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

  Future<void> randomWalletPassword() async {
    final uuid = const Uuid().v4();
    await setWalletPassword(uuid);
  }

  Future<void> setWalletPassword(String password) async {
    await store.record('enjin.wallet.password').put(db, password);
    walletPassword = password;
  }

  void loadData() async {
    final String? password =
        await store.record('enjin.wallet.password').get(db) as String?;
    final String? selectedNetwork =
        await store.record('enjin.current.platform').get(db) as String?;

    checkIsRunning();

    if (isRunning && getIt.get<DaemonService>().hasAddress) {
      setState(() {
        _walletAddress.text = getIt.get<DaemonService>().address!;
      });

      getIt.get<DaemonService>().setCallback(addToOutput: addToOutput);
    }

    setState(() {
      walletPassword = password ?? '';
      currentNetwork = selectedNetwork ?? 'enjin-matrix';
    });
  }

  Future<void> setCurrentNetwork(String network) async {
    await store.record('enjin.current.platform').put(db, network);

    setState(() {
      currentNetwork = network;
    });
  }

  Future<void> writeLockPassword(String password) async {
    await store.record('enjin.lock.password').put(db, password);
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    loadData();

    try {
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null) {
        WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
          onboarding.show();
        });
      }
    } catch (_) {}
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

  Future<void> _showSetPasswordDialog(BuildContext context) async {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => SimpleDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enjin Platform - Lock Screen'),
              ],
            ),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            children: <Widget>[
              const SizedBox(
                height: 16,
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
                  MaterialButton(
                    onPressed: () async {
                      if (passwordController.text == repeatController.text &&
                          passwordController.text.length >= 8) {
                        await writeLockPassword(passwordController.text);
                        Beamer.of(context).beamToReplacementNamed('/lock');
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
          ),
        );
      },
    );
  }

  Future<void> _showLockScreen(BuildContext context) async {
    // bool hasPassword =
    //     await secureStorage.containsKey(key: 'enjin.lock.password');

    // if (hasPassword) {
    //   await store.record('enjin.is_locked', value: 'true');
    //
    //   Beamer.of(context).beamToNamed('/lock');
    // } else {
    await _showSetPasswordDialog(context);
    // }
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

  Future<void> lockScreen() async {
    await getIt.get<StoreService>().db.close();
    Beamer.of(context).beamToNamed('/lock');
  }

  Future<void> setupStart() async {
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
// https://wiki.polkadot.network/docs/learn-account-advanced#derivation-paths
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
                          await setWalletPassword(passwordController.text);
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
                      await randomWalletPassword();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await lockScreen(),
        backgroundColor: const Color(0xFF7866D5),
        child: const Icon(
          Icons.lock,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7866D5),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: Image.asset('lib/assets/White.png'),
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Wallet Daemon',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  value: currentNetwork,
                  focusNode: _selectNetwork,
                  style: const TextStyle(
                    color: Color(0xFF858997),
                    fontSize: 15,
                    fontFamily: 'Hauora',
                    fontWeight: FontWeight.w800,
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
                  onChanged: (String? value) {
                    if (value == 'custom-endpoint') {
                      _showCustomPlatformDialog();
                      return;
                    }
                    setCurrentNetwork(value!);
                    stopWallet();

                    _selectNetwork.nextFocus();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                if (_walletAddress.text != '')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          text: 'Wallet Address ',
                          style: const TextStyle(
                            color: Color(0xFF434A60),
                            fontSize: 12,
                            fontFamily: 'Hauora',
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            if (isRunning)
                              TextSpan(
                                text: '(running)',
                                style: TextStyle(
                                  color: Colors.green[700],
                                ),
                              )
                            else
                              TextSpan(
                                text: '(stopped)',
                                style: TextStyle(
                                  color: Colors.red[700],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 420,
                        child: TextField(
                          readOnly: true,
                          controller: _walletAddress,
                          style: const TextStyle(
                            color: Color(0xFF858997),
                            fontSize: 13,
                            fontFamily: 'Hauora',
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                const Spacer(),
                Opacity(
                  opacity: isRunning ? 0.5 : 1,
                  child: MaterialButton(
                    focusNode: getIt.get<StoreService>().focusNode,
                    onPressed: () => runWallet(),
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    color: const Color(0xFF7866D5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Opacity(
                  opacity: isRunning ? 1.0 : 0.5,
                  child: MaterialButton(
                    onPressed: () => stopWallet(),
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    color: const Color(0xFF7866D5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Stop",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () => _showConfigDialog(context),
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: const Color(0xFF7866D5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Configs",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: TerminalView(
              terminal,
              padding: const EdgeInsets.only(top: 10),
              readOnly: true,
            ),
          )
        ],
      ),
    );
  }
}
