sealed class SettingsIntent {
  const SettingsIntent();
}

class LoadSettingsIntent extends SettingsIntent {
  const LoadSettingsIntent();
}

class SaveWebViewUrlIntent extends SettingsIntent {
  final String url;
  const SaveWebViewUrlIntent(this.url);
}

class SaveSelectedDeviceIntent extends SettingsIntent {
  final String device;
  const SaveSelectedDeviceIntent(this.device);
}

class NavigateToWebViewIntent extends SettingsIntent {
  const NavigateToWebViewIntent();
}




