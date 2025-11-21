import '../../domain/entities/settings_entity.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsEntity> getSettings();
  Future<void> saveWebViewUrl(String url);
  Future<void> saveSelectedDevice(String device);
}




