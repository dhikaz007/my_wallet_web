part of 'helpers.dart';

class DataGridHelpers {
  static const MethodChannel _platformCall = MethodChannel('launchFile');

  static Future<void> saveMobile(
    List<int> bytes,
    String fileName,
  ) async {
    String? path;
    if (Platform.isAndroid) {
      final Directory? directory = await getExternalStorageDirectory();
      if (directory != null) {
        path = directory.path;
      }
    } else if (Platform.isIOS || Platform.isLinux || Platform.isWindows) {
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file = File(
      Platform.isWindows ? '$path\\$fileName' : '$path/$fileName',
    );
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      final Map<String, String> argument = <String, String>{
        'file_path': '$path/$fileName',
      };
      try {
        //ignore: unused_local_variable
        final Future<Map<String, String>?> result = _platformCall.invokeMethod(
          'viewExcel',
          argument,
        );
      } catch (e) {
        throw Exception(e);
      }
    } else if (Platform.isWindows) {
      await Process.run(
          'start',
          <String>[
            '$path\\$fileName',
          ],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run(
          'xdg-open',
          <String>[
            '$path/$fileName',
          ],
          runInShell: true);
    }
  }

  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    web.AnchorElement()
      ..href =
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}'
      ..setAttribute('download', fileName)
      ..click();
  }
}
