import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../entities/webview_entity.dart';
import '../repositories/webview_repository.dart';

class GetWebViewUrlUseCase {
  final WebViewRepository repository;

  GetWebViewUrlUseCase(this.repository);

  Future<Result<WebViewEntity, Failure>> call() async {
    return await repository.getWebViewUrl();
  }
}




