import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../repositories/settings_repository.dart';

class SaveSelectedDeviceUseCase {
  final SettingsRepository repository;

  SaveSelectedDeviceUseCase(this.repository);

  Future<Result<void, Failure>> call(String device) async {
    return await repository.saveSelectedDevice(device);
  }
}




