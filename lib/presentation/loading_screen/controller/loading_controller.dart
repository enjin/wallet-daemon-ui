import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:daemon/core/app_export.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../routes/app_pages.dart';

class LoadingController extends GetxController {
  static LoadingController get to => Get.find();

  final latestVersion = ''.obs;

  @override
  void onReady() {
    super.onReady();

    _checkDependencies();
  }

  Future<({String? assetUrl, String? tagName})> _getLatestRelease() async {
    final dio = Dio();
    final response = await dio.get(
        'https://api.github.com/repos/enjin/wallet-daemon/releases/latest');

    final assets = response.data['assets'] ?? [];
    final String tagName = response.data['tag_name'];

    String system = Platform.operatingSystem;
    if (system == 'macos') {
      system = 'apple';
    }

    for (var asset in assets) {
      final String assetUrl = asset['browser_download_url'];

      if (assetUrl.contains('sha256sum')) continue;
      if (assetUrl.contains(system)) {
        return (
          assetUrl: assetUrl,
          tagName: tagName,
        );
      }
    }

    return (
      assetUrl: null,
      tagName: null,
    );
  }

  Future<void> _getDaemonService(String path) async {
    final (:assetUrl, :tagName) = await _getLatestRelease();

    if (assetUrl == null) return;
    if (tagName != null) latestVersion.value = tagName;

    final task = DownloadTask(
      url: assetUrl,
      filename: 'wallet_daemon_latest.zip',
      baseDirectory: BaseDirectory.applicationSupport,
    );

    await FileDownloader().download(task);
    extractFileToDisk(p.join(path, 'wallet_daemon_latest.zip'), path);
  }

  Future<void> _checkDependencies() async {
    final Directory appDir = await getApplicationSupportDirectory();

    await _getDaemonService(appDir.path);
    await _checkAndCopyConfig(appDir.path);

    final hasDatabase = await _checkDatabaseExists(appDir.path);

    Future.delayed(
      const Duration(seconds: 1),
      () => hasDatabase
          ? Get.offNamed(Routes.lock.nameToRoute())
          : Get.offNamed(Routes.onboard.nameToRoute()),
    );
  }

  Future<bool> _checkDatabaseExists(String path) async {
    final String fullPath = p.join(path, 'daemon.db');
    return File(fullPath).existsSync();
  }

  Future<void> _checkAndCopyConfig(String path) async {
    String configFile = '$path/config.json';
    await _copyAsset('config.json', configFile);
  }

  Future<void> _copyAsset(String asset, String to) async {
    final data = await rootBundle.load(asset);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final buffer = await File(to).create(recursive: true);
    buffer.writeAsBytesSync(bytes);
  }
}
