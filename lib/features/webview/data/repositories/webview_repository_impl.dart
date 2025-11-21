import '../../domain/repositories/webview_repository.dart';
import '../../domain/entities/webview_entity.dart';
import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../datasources/webview_local_datasource.dart';

class WebViewRepositoryImpl implements WebViewRepository {
  final WebViewLocalDataSource localDataSource;

  WebViewRepositoryImpl(this.localDataSource);

  @override
  Future<Result<WebViewEntity, Failure>> getWebViewUrl() async {
    try {
      final webView = await localDataSource.getWebViewUrl();
      return Success(webView);
    } catch (e) {
      return Error(ServerFailure(errorMessage: e.toString()));
    }
  }
}




