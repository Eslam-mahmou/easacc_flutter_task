import '../../domain/entities/webview_entity.dart';

abstract class WebViewLocalDataSource {
  Future<WebViewEntity> getWebViewUrl();
}




