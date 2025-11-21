import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../repositories/settings_repository.dart';

class SaveWebViewUrlUseCase {
  final SettingsRepository repository;

  SaveWebViewUrlUseCase(this.repository);

  Future<Result<void, Failure>> call(String url) async {
    return await repository.saveWebViewUrl(url);
  }
}




