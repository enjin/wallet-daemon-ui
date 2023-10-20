import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';

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
  String currentNetwork = 'enjin-matrix';

  List<String> output = [];
  late Process daemon;
  String walletAddress = '';

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
        "KEY_PASS": "testando",
        "CONFIG_FILE": "config.json",
      },
    );
    daemon.stdout.transform(utf8.decoder).forEach(addToOutput);
  }

  void stopWallet() {
    // Should probably not clear // make an option later to clear
    setState(() {
      output = [];
      walletAddress = '';
    });

    daemon.kill();
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
                    onPressed: () {},
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
