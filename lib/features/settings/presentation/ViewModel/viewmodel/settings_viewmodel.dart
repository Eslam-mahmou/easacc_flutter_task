import 'package:flutter_bloc/flutter_bloc.dart';
import '../intent/settings_intent.dart';
import '../state/settings_state.dart';
import '../../../domain/usecases/get_settings_usecase.dart';
import '../../../domain/usecases/save_webview_url_usecase.dart';
import '../../../domain/usecases/save_selected_device_usecase.dart';

class SettingsViewModel extends Cubit<SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final SaveWebViewUrlUseCase saveWebViewUrlUseCase;
  final SaveSelectedDeviceUseCase saveSelectedDeviceUseCase;

  final List<String> _availableDevices = [
    'WiFi Device 1',
    'WiFi Device 2',
    'Bluetooth Printer 1',
    'Bluetooth Printer 2',
  ];

  SettingsViewModel({
    required this.getSettingsUseCase,
    required this.saveWebViewUrlUseCase,
    required this.saveSelectedDeviceUseCase,
  }) : super(const SettingsState.initial());

  void handleIntent(SettingsIntent intent) {
    switch (intent) {
      case LoadSettingsIntent():
        _loadSettings();
      case SaveWebViewUrlIntent(:final url):
        _saveWebViewUrl(url);
      case SaveSelectedDeviceIntent(:final device):
        _saveSelectedDevice(device);
      case NavigateToWebViewIntent():
        break;
    }
  }

  Future<void> _loadSettings() async {
    emit(const SettingsState.loading());
    final result = await getSettingsUseCase();

    result.when(
      success: (settings) {
        emit(SettingsState.loaded(
          webViewUrl: settings.webViewUrl,
          selectedDevice: settings.selectedDevice,
          availableDevices: _availableDevices,
        ));
      },
      error: (failure) => emit(SettingsState.failure(failure.errorMessage)),
    );
  }

  Future<void> _saveWebViewUrl(String url) async {
    emit(const SettingsState.saving());
    final result = await saveWebViewUrlUseCase(url);

    result.when(
      success: (_) {
        state.whenOrNull(
          loaded: (currentUrl, selectedDevice, availableDevices) {
            emit(SettingsState.loaded(
              webViewUrl: url,
              selectedDevice: selectedDevice,
              availableDevices: availableDevices,
            ));
            emit(const SettingsState.saved());
            emit(SettingsState.loaded(
              webViewUrl: url,
              selectedDevice: selectedDevice,
              availableDevices: availableDevices,
            ));
          },
        ) ?? emit(const SettingsState.saved());
      },
      error: (failure) => emit(SettingsState.failure(failure.errorMessage)),
    );
  }

  Future<void> _saveSelectedDevice(String device) async {
    emit(const SettingsState.saving());
    final result = await saveSelectedDeviceUseCase(device);

    result.when(
      success: (_) {
        state.whenOrNull(
          loaded: (webViewUrl, currentDevice, availableDevices) {
            emit(SettingsState.loaded(
              webViewUrl: webViewUrl,
              selectedDevice: device,
              availableDevices: availableDevices,
            ));
            emit(const SettingsState.saved());
            emit(SettingsState.loaded(
              webViewUrl: webViewUrl,
              selectedDevice: device,
              availableDevices: availableDevices,
            ));
          },
        ) ?? emit(const SettingsState.saved());
      },
      error: (failure) => emit(SettingsState.failure(failure.errorMessage)),
    );
  }

  bool canNavigateToWebView() {
    return state.maybeWhen(
      loaded: (webViewUrl, selectedDevice, availableDevices) =>
          webViewUrl != null && webViewUrl.trim().isNotEmpty,
      orElse: () => false,
    );
  }

  String? getWebViewUrl() {
    return state.maybeWhen(
      loaded: (webViewUrl, selectedDevice, availableDevices) => webViewUrl,
      orElse: () => null,
    );
  }
}

