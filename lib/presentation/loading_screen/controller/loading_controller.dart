import 'dart:io';

import 'package:dio/dio.dart';
import 'package:download_assets/download_assets.dart';
import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


class LoadingController extends GetxController {
  static LoadingController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _checkDependencies();
  }

  Future<void> _checkDependencies() async {
    final Directory appDir = await getApplicationSupportDirectory();
    final DownloadAssetsController downloadAssetsController =
        DownloadAssetsController();

    bool hasService = await _checkWalletServiceExists(
      path: appDir.path,
      downloadController: downloadAssetsController,
    );

    if (!hasService) {
      await _downloadDaemon(downloadController: downloadAssetsController);
    }

    await _checkAndCopyConfig(appDir.path);

    bool hasDatabase = await _checkDatabaseExists(appDir.path);

    Future.delayed(
      const Duration(seconds: 1),
      () => hasDatabase
          ? Get.offNamed(Routes.onboard.nameToRoute())
          : Get.offNamed(Routes.onboard.nameToRoute()),
    );
  }

  Future<bool> _checkDatabaseExists(String path) async {
    final String fullPath = p.join(path, 'daemon.db');
    return File(fullPath).existsSync();
  }

  Future<bool> _checkWalletServiceExists({
    required String path,
    required DownloadAssetsController downloadController,
  }) async {
    await downloadController.init(
      assetDir: path,
      useFullDirectoryPath: true,
    );

    return await downloadController.assetsFileExists('wallet');
  }

  Future<void> _downloadDaemon({
    required DownloadAssetsController downloadController,
  }) async {
    String? assetUrl = await _getLatestRelease();

    if (assetUrl != null) {
      await downloadController.startDownload(
        onCancel: () {},
        assetsUrls: [assetUrl],
        onProgress: (progressValue) {},
      );
    }
  }

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

  Future<void> _copyAsset(String asset, String to) async {
    final data = await rootBundle.load(asset);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final buffer = await File(to).create(recursive: true);
    buffer.writeAsBytesSync(bytes);
  }

  Future<void> _checkAndCopyConfig(String path) async {
    String configFile = '$path/config.json';
    await _copyAsset('config.json', configFile);
  }
}
