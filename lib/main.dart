import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
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
      ),
      home: const MyHomePage(title: 'Enjin Wallet Daemon'),
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
  final TextEditingController _enjinMatrixKey = new TextEditingController();
  final TextEditingController _canaryMatrixKey = new TextEditingController();
  final TextEditingController _walletPassword = new TextEditingController();

  String currentNetwork = 'enjin-matrix';
  final platformKeys = {
    'enjin-matrix': '',
    'canary-matrix': '',
  };

  String walletPassword = '';

  List<String> output = [];
  Process? daemon;
  String walletAddress = '';

  void setConfig() {
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
    File('config.json').writeAsStringSync(configJson);
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

    setState(() {
      output.add(otp);
    });
  }

  void runWallet() async {
    daemon = await Process.start(
      'wallet/linux/wallet',
      [],
      environment: {
        "KEY_PASS": 'testando', //walletPassword,
        "PLATFORM_KEY": platformKeys[currentNetwork] ?? '',
        "CONFIG_FILE": "config.json",
      },
    );
    daemon!.stdout.transform(utf8.decoder).forEach(addToOutput);
  }

  void stopWallet() {
    // Should probably not clear // make an option later to clear
    setState(() {
      output = [];
      walletAddress = '';
    });

    if (daemon != null) {
      daemon!.kill();
    }
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

  void setKeys() {
    platformKeys['enjin-matrix'] = _enjinMatrixKey.text;
    platformKeys['canary-matrix'] = _canaryMatrixKey.text;
    walletPassword = _walletPassword.text;
  }

  // 7wlRtl54SDVwXfKsnOjmthTrGrOOHLe9K30mWDpT2bfc9efb

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

  @override
  void initState() {
    super.initState();
    if (walletPassword == '') {
      walletPassword = const Uuid().v4();
      _walletPassword.text = walletPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7866D5),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 0),
          child: Image.asset('lib/assets/White.png'),
        ),
        title: Text(
          'Wallet Daemon',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      print(currentNetwork);
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
              child: Container(
                color: Colors.black,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: getText(),
                  ),
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
