import 'package:freezed_annotation/freezed_annotation.dart';

part 'webview_state.freezed.dart';

@freezed
class WebViewState with _$WebViewState {
  const factory WebViewState.initial() = _Initial;
  const factory WebViewState.loading() = _Loading;
  const factory WebViewState.loaded({
    required String url,
  }) = _Loaded;
  const factory WebViewState.pageLoading() = _PageLoading;
  const factory WebViewState.pageLoaded() = _PageLoaded;
  const factory WebViewState.failure(String message) = _Failure;
}




