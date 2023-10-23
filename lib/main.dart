import 'dart:convert';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import 'package:download_assets/download_assets.dart';
import 'package:xterm/xterm.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(1000, 800);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: const Color(0xFFFAFAFA),
        centerBackground: true,
        finishButtonText: 'Launch',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Color(0xFF7866D5),
        ),
        background: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SvgPicture.asset('lib/assets/undraw_welcome.svg'),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SvgPicture.asset('lib/assets/undraw_synchronize.svg'),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SvgPicture.asset('lib/assets/undraw_launch.svg'),
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        onFinish: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        },
        pageBodies: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Welcome to Enjin Platform',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text('The best blockchain platform built for game developers'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Text(
                'This application is a wallet daemon that connects to the platform\nallowing transactions to be signed automatically for you.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enjin Wallet Daemon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: "Hauora",
            color: Color(0xFF434A60),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Enjin Wallet Daemon'),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Terminal terminal = Terminal();
  TerminalController terminalController = TerminalController();

  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  bool downloaded = false;
  double value = 0.0;

  final TextEditingController _enjinMatrixKey = TextEditingController();
  final TextEditingController _canaryMatrixKey = TextEditingController();
  final TextEditingController _walletPassword = TextEditingController();

  String currentNetwork = 'enjin-matrix';
  final platformKeys = {
    'enjin-matrix': '',
    'canary-matrix': '',
  };

  Future _init() async {
    await downloadAssetsController.init(
      assetDir: (await getApplicationSupportDirectory()).path,
      useFullDirectoryPath: true,
    );

    bool hasWallet = await downloadAssetsController.assetsFileExists('wallet');

    setState(() {
      downloaded = hasWallet;
    });
  }

  String walletPassword = '';

  List<String> output = [];
  Process? daemon;
  String walletAddress = '';

  void _downloadDaemon() async {
    final String system = Platform.operatingSystem;
    String assetUrl = '';

    if (system == 'macos') {
      assetUrl =
          'https://github.com/enjin/wallet-daemon/releases/download/v1.0.0-beta.5/wallet-daemon_v1.0.0-beta.5_x86_64-apple-darwin.zip';
    } else if (system == 'windows') {
      assetUrl =
          'https://github.com/enjin/wallet-daemon/releases/download/v1.0.0-beta.5/wallet-daemon_v1.0.0-beta.5_x86_64-pc-windows-gnu.zip';
    } else {
      assetUrl =
          'https://github.com/enjin/wallet-daemon/releases/download/v1.0.0-beta.5/wallet-daemon_v1.0.0-beta.5_x86_64-unknown-linux-musl.zip';
    }

    await downloadAssetsController.startDownload(
      onCancel: () {
        //TODO: implement cancel here
      },
      assetsUrls: [assetUrl],
      onProgress: (progressValue) {
        print(progressValue);

        setState(() {
          value = progressValue;
        });
      },
    );

    print(downloadAssetsController.assetsDir);

    final directory = await getApplicationSupportDirectory();
    String configFile = '${directory.path}/config.json';
    copyAsset('config.json', configFile);

    setState(() {
      downloaded = true;
    });
  }

  void setConfig() async {
    final configs = {
      'enjin-matrix': {
        "node": "wss://rpc.matrix.blockchain.enjin.io:443",
        "api": "https://platform.enjin.io/graphql",
        "master_key": "store"
      },
      'canary-matrix': {
        "node": "wss://rpc.matrix.canary.enjin.io:443",
        "api": "https://platform.canary.enjin.io/graphql",
        "master_key": "store"
      }
    };

    final config = configs[currentNetwork];
    final configJson = jsonEncode(config);

    final directory = await getApplicationSupportDirectory();
    File(p.join(directory.path, 'config.json')).writeAsStringSync(configJson);
  }

  void addToOutput(String otp) {
    if (walletAddress == '' && otp.contains('Enjin Matrix:')) {
      for (String word in otp.split(' ')) {
        final prefix = currentNetwork == 'enjin-matrix' ? 'ef' : 'cx';
        if (word.startsWith(prefix)) {
          String address = word.split('\n')[0];
          setState(() {
            walletAddress = address;
          });
        }
      }
    }

    terminal.write(otp);
    terminal.nextLine();
  }

  void runWallet() async {
    final directory = await getApplicationSupportDirectory();
    String workingDir = directory.path;
    String walletApp = '$workingDir/wallet';
    String configFile = '$workingDir/config.json';

    await Process.run("chmod", ["+x", walletApp]);
    daemon = await Process.start(
      walletApp,
      [],
      environment: {
        "KEY_PASS": walletPassword,
        "PLATFORM_KEY": platformKeys[currentNetwork] ?? '',
        "CONFIG_FILE": configFile,
      },
      workingDirectory: workingDir,
      runInShell: true,
    );

    daemon!.stdout.transform(utf8.decoder).forEach(addToOutput);
  }

  void stopWallet() {
    setState(() {
      walletAddress = '';
    });

    if (daemon != null) {
      daemon!.kill();
    }
  }

  void copyAsset(String asset, String to) async {
    final data = await rootBundle.load(asset);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final buffer = await File(to).create(recursive: true);
    buffer.writeAsBytesSync(bytes);
  }

  List<Widget> getText() {
    List<Widget> widgets = [];
    for (var i = 0; i < output.length; i++) {
      widgets.insert(
        0,
        Text(
          output[i],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return widgets;
  }

  void setKeys() async {
    platformKeys['enjin-matrix'] = _enjinMatrixKey.text;
    platformKeys['canary-matrix'] = _canaryMatrixKey.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('enjin.matrix.key', _enjinMatrixKey.text);
    await prefs.setString('enjin.canary.key', _canaryMatrixKey.text);
  }

  Future<void> _showConfigDialog() async {
    _enjinMatrixKey.text = platformKeys['enjin-matrix'] ?? '';
    _canaryMatrixKey.text = platformKeys['canary-matrix'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enjin Platform - Configuration'),
            ],
          ),
          contentPadding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Text(
              'Enjin Matrixchain',
              style: TextStyle(
                color: Color(0xFF434A60),
                fontSize: 12,
                fontFamily: 'Hauora',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 360,
              height: 48,
              child: TextField(
                controller: _enjinMatrixKey,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
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
            SizedBox(
              height: 16,
            ),
            Text(
              'Canary Matrixchain',
              style: TextStyle(
                color: Color(0xFF434A60),
                fontSize: 12,
                fontFamily: 'Hauora',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 360,
              height: 48,
              child: TextField(
                controller: _canaryMatrixKey,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
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
            SizedBox(
              height: 16,
            ),
            Text(
              'Auto generated wallet password (read-only)',
              style: TextStyle(
                color: Color(0xFF434A60),
                fontSize: 12,
                fontFamily: 'Hauora',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 360,
              height: 48,
              child: TextField(
                readOnly: true,
                controller: _walletPassword,
                decoration: InputDecoration(
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
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    setKeys();
                    Navigator.pop(context);
                  },
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Color(0xFF7866D5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Color(0xFF7866D5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
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

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? password = prefs.getString('enjin.wallet.password');
    final String? enjinMatrixKey = prefs.getString('enjin.matrix.key');
    final String? enjinCanaryKey = prefs.getString('enjin.canary.key');
    final String? selectedNetwork = prefs.getString('enjin.network');
    print("Loaded password: $password");
    print("Loaded enjinMatrixKey: $enjinMatrixKey");
    print("Loaded enjinCanaryKey: $enjinCanaryKey");
    print("Loaded selectedNetwork: $selectedNetwork");

    if (password == null) {
      print("Generating new password");
      final uuid = const Uuid().v4();
      await prefs.setString('enjin.wallet.password', uuid);
      walletPassword = uuid;
      _walletPassword.text = uuid;
      print("Generated password: $uuid");
    }

    setState(() {
      walletPassword = password ?? walletPassword;
      _walletPassword.text = walletPassword;
      currentNetwork = selectedNetwork ?? 'enjin-matrix';
      platformKeys['enjin-matrix'] = enjinMatrixKey ?? '';
      platformKeys['canary-matrix'] = enjinCanaryKey ?? '';
    });
  }

  void setCurrentNetwork() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('enjin.network', currentNetwork);
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7866D5),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: Image.asset('lib/assets/White.png'),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              'Wallet Daemon',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    DropdownMenu<String>(
                      initialSelection: currentNetwork,
                      onSelected: (String? value) {
                        currentNetwork = value!;
                        setCurrentNetwork();
                        stopWallet();
                        setConfig();
                      },
                      dropdownMenuEntries: [
                        DropdownMenuEntry<String>(
                          value: 'enjin-matrix',
                          label: 'Enjin Matrix',
                        ),
                        DropdownMenuEntry<String>(
                          value: 'canary-matrix',
                          label: 'Canary Matrix',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (walletAddress != '')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Wallet Address',
                            style: TextStyle(
                              color: Color(0xFF434A60),
                              fontSize: 12,
                              fontFamily: 'Hauora',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            walletAddress,
                            style: TextStyle(
                              color: Color(0xFF858997),
                              fontSize: 13,
                              fontFamily: 'Hauora',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    Spacer(),
                    MaterialButton(
                      onPressed: () => runWallet(),
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: Color(0xFF7866D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () => stopWallet(),
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: Color(0xFF7866D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Stop",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: _showConfigDialog,
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: Color(0xFF7866D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Configs",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
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
          if (!downloaded)
            Container(
              height: 300,
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('lib/assets/enjin.png'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'We need to fetch the latest version of Enjin Wallet Daemon service. Click below to start the download.'),
                  Spacer(),
                  if (value != 0 && value != 100) CircularProgressIndicator(),
                  Spacer(),
                  MaterialButton(
                    onPressed: () => _downloadDaemon(),
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    color: Color(0xFF7866D5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Download",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Onboard();
  }
}
