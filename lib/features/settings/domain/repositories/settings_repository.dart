import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<Result<SettingsEntity, Failure>> getSettings();
  Future<Result<void, Failure>> saveWebViewUrl(String url);
  Future<Result<void, Failure>> saveSelectedDevice(String device);
}




