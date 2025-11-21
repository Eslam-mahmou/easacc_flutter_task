import '../../../../core/service/shared_pref_helper.dart';
import '../../domain/entities/webview_entity.dart';
import 'webview_local_datasource.dart';

class WebViewLocalDataSourceImpl implements WebViewLocalDataSource {
  @override
  Future<WebViewEntity> getWebViewUrl() async {
    final url = await SharedPrefHelper.getString('webview_url');
    
    return WebViewEntity(
      url: url ?? 'https://www.google.com',
    );
  }
}




