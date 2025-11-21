import 'package:flutter_bloc/flutter_bloc.dart';
import '../intent/webview_intent.dart';
import '../state/webview_state.dart';
import '../../../domain/usecases/get_webview_url_usecase.dart';

class WebViewViewModel extends Cubit<WebViewState> {
  final GetWebViewUrlUseCase getWebViewUrlUseCase;

  WebViewViewModel({
    required this.getWebViewUrlUseCase,
  }) : super(const WebViewState.initial());

  void handleIntent(WebViewIntent intent) {
    switch (intent) {
      case LoadWebViewIntent():
        _loadWebView();
      case RefreshWebViewIntent():
        _refreshWebView();
    }
  }

  Future<void> _loadWebView() async {
    emit(const WebViewState.loading());
    final result = await getWebViewUrlUseCase();

    result.when(
      success: (webView) {
        emit(WebViewState.loaded(url: webView.url));
      },
      error: (failure) => emit(WebViewState.failure(failure.errorMessage)),
    );
  }

  Future<void> _refreshWebView() async {
    state.whenOrNull(
      loaded: (url) {
        emit(const WebViewState.pageLoading());
        emit(WebViewState.loaded(url: url));
      },
    );
  }

  void onPageStarted() {
    emit(const WebViewState.pageLoading());
  }

  void onPageFinished() {
    emit(const WebViewState.pageLoaded());
  }

  void onPageError(String error) {
    emit(WebViewState.failure(error));
  }
}

