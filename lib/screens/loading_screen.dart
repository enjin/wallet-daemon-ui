import 'dart:io';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final DownloadAssetsController _downloadAssetsController =
      DownloadAssetsController();

  Future<String?> _getLatestRelease() async {
    final dio = Dio();
    final response = await dio.get(
        'https://api.github.com/repos/enjin/wallet-daemon/releases/latest');

    final assets = response.data['assets'] ?? [];
    String system = Platform.operatingSystem;
    if (system == 'macos') {
      system = 'apple';
    }

    for (var asset in assets) {
      final String assetUrl = asset['browser_download_url'];

      if (assetUrl.contains('sha256sum')) continue;
      if (assetUrl.contains(system)) {
        return assetUrl;
      }
    }

    return null;
  }

  void copyAsset(String asset, String to) async {
    final data = await rootBundle.load(asset);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final buffer = await File(to).create(recursive: true);
    buffer.writeAsBytesSync(bytes);
  }

  Future<void> _checkAndCopyConfig() async {
    final directory = await getApplicationSupportDirectory();
    String configFile = '${directory.path}/config.json';
    copyAsset('config.json', configFile);
  }

  Future<void> _downloadDaemon() async {
    String? assetUrl = await _getLatestRelease();

    if (assetUrl != null) {
      await _downloadAssetsController.startDownload(
        onCancel: () {},
        assetsUrls: [assetUrl],
        onProgress: (progressValue) {},
      );
    }
  }

  _loadDependencies(BuildContext context) async {
    final Directory appDir = await getApplicationSupportDirectory();
    final String fullPath = p.join(appDir.path, 'daemon.db');
    final bool isInitialized = File(fullPath).existsSync();

    await _downloadAssetsController.init(
      assetDir: (await getApplicationSupportDirectory()).path,
      useFullDirectoryPath: true,
    );

    final bool hasWalletExe =
        await _downloadAssetsController.assetsFileExists('wallet');
    if (!hasWalletExe) {
      await _downloadDaemon();
    }

    await _checkAndCopyConfig();

    Future.delayed(
      const Duration(seconds: 1),
      () => isInitialized
          ? Beamer.of(context).beamToReplacementNamed('/lock')
          : Beamer.of(context).beamToReplacementNamed('/onboard'),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadDependencies(context);
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
              SvgPicture.asset('lib/assets/enjin_logo_white.svg'),
              LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 200,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
