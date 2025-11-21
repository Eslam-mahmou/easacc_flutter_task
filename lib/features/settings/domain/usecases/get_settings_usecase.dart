import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Result<SettingsEntity, Failure>> call() async {
    return await repository.getSettings();
  }
}




