import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../ViewModel/viewmodel/webview_viewmodel.dart';
import '../ViewModel/intent/webview_intent.dart';
import '../ViewModel/state/webview_state.dart';
import 'package:esacc_flutter_task/features/webview/domain/usecases/get_webview_url_usecase.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebViewViewModel(
        getWebViewUrlUseCase: getIt<GetWebViewUrlUseCase>(),
      )..handleIntent(const LoadWebViewIntent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Web View'),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          actions: [
            BlocBuilder<WebViewViewModel, WebViewState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  loaded: (_) => IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context.read<WebViewViewModel>().handleIntent(
                            const RefreshWebViewIntent(),
                          );
                    },
                  ),
                  pageLoading: () => const SizedBox.shrink(),
                  pageLoaded: () => const SizedBox.shrink(),
                  failure: (_) => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<WebViewViewModel, WebViewState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (url) => _buildWebView(context, url),
              pageLoading: () {
                return state.maybeWhen(
                  loaded: (url) => Stack(
                    children: [
                      _buildWebView(context, url),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                  orElse: () => const Center(child: CircularProgressIndicator()),
                );
              },
              pageLoaded: () {
                return state.maybeWhen(
                  loaded: (url) => _buildWebView(context, url),
                  orElse: () => const Center(child: CircularProgressIndicator()),
                );
              },
              failure: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: context.heightPct(0.02)),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WebViewViewModel>().handleIntent(
                              const LoadWebViewIntent(),
                            );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWebView(BuildContext context, String url) {
    final viewModel = context.read<WebViewViewModel>();
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            viewModel.onPageStarted();
          },
          onPageFinished: (String url) {
            viewModel.onPageFinished();
          },
          onWebResourceError: (WebResourceError error) {
            viewModel.onPageError(error.description);
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return WebViewWidget(controller: controller);
  }
}

