import '../../domain/repositories/settings_repository.dart';
import '../../domain/entities/settings_entity.dart';
import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<Result<SettingsEntity, Failure>> getSettings() async {
    try {
      final settings = await localDataSource.getSettings();
      return Success(settings);
    } catch (e) {
      return Error(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> saveWebViewUrl(String url) async {
    try {
      await localDataSource.saveWebViewUrl(url);
      return const Success(null);
    } catch (e) {
      return Error(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> saveSelectedDevice(String device) async {
    try {
      await localDataSource.saveSelectedDevice(device);
      return const Success(null);
    } catch (e) {
      return Error(ServerFailure(errorMessage: e.toString()));
    }
  }
}




