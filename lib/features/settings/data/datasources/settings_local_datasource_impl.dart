import '../../../../core/service/shared_pref_helper.dart';
import '../../domain/entities/settings_entity.dart';
import 'settings_local_datasource.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  @override
  Future<SettingsEntity> getSettings() async {
    final webViewUrl = await SharedPrefHelper.getString('webview_url');
    final selectedDevice = await SharedPrefHelper.getString('selected_device');

    return SettingsEntity(
      webViewUrl: webViewUrl,
      selectedDevice: selectedDevice,
    );
  }

  @override
  Future<void> saveWebViewUrl(String url) async {
    await SharedPrefHelper.setString('webview_url', url);
  }

  @override
  Future<void> saveSelectedDevice(String device) async {
    await SharedPrefHelper.setString('selected_device', device);
  }
}




