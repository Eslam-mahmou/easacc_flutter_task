import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.loading() = _Loading;
  const factory SettingsState.loaded({
    required String? webViewUrl,
    required String? selectedDevice,
    required List<String> availableDevices,
  }) = _Loaded;
  const factory SettingsState.saving() = _Saving;
  const factory SettingsState.saved() = _Saved;
  const factory SettingsState.failure(String message) = _Failure;
}




