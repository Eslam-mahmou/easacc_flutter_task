import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../entities/webview_entity.dart';

abstract class WebViewRepository {
  Future<Result<WebViewEntity, Failure>> getWebViewUrl();
}




