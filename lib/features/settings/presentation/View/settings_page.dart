import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/pages_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../ViewModel/viewmodel/settings_viewmodel.dart';
import '../ViewModel/intent/settings_intent.dart';
import '../ViewModel/state/settings_state.dart';
import 'package:esacc_flutter_task/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:esacc_flutter_task/features/settings/domain/usecases/save_webview_url_usecase.dart';
import 'package:esacc_flutter_task/features/settings/domain/usecases/save_selected_device_usecase.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsViewModel(
        getSettingsUseCase: getIt<GetSettingsUseCase>(),
        saveWebViewUrlUseCase: getIt<SaveWebViewUrlUseCase>(),
        saveSelectedDeviceUseCase: getIt<SaveSelectedDeviceUseCase>(),
      )..handleIntent(const LoadSettingsIntent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: BlocConsumer<SettingsViewModel, SettingsState>(
          listener: (context, state) {
            state.whenOrNull(
              saved: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings saved successfully')),
                );
              },
              failure: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (webViewUrl, selectedDevice, availableDevices) {
                if (_urlController.text.isEmpty && webViewUrl != null) {
                  _urlController.text = webViewUrl;
                }

                return Padding(
                  padding: EdgeInsets.all(context.widthPct(0.05)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: context.heightPct(0.02)),
                      Text(
                        'Web View URL',
                        style: TextStyle(
                          fontSize: context.fontPct(0.018),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.heightPct(0.01)),
                      TextField(
                        controller: _urlController,
                        decoration: InputDecoration(
                          hintText: 'Enter website URL (e.g., https://example.com)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.link),
                        ),
                        keyboardType: TextInputType.url,
                      ),
                      SizedBox(height: context.heightPct(0.02)),
                      ElevatedButton(
                        onPressed: state.maybeWhen(
                          saving: () => null,
                          orElse: () => () {
                            context.read<SettingsViewModel>().handleIntent(
                                  SaveWebViewUrlIntent(_urlController.text.trim()),
                                );
                          },
                        ) as VoidCallback?,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: context.heightPct(0.02)),
                        ),
                        child: state.maybeWhen(
                          saving: () => const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          orElse: () => const Text('Save URL'),
                        ),
                      ),
                      SizedBox(height: context.heightPct(0.04)),
                      Text(
                        'Network Devices',
                        style: TextStyle(
                          fontSize: context.fontPct(0.018),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.heightPct(0.01)),
                      DropdownButtonFormField<String>(
                        initialValue: selectedDevice,
                        decoration: InputDecoration(
                          hintText: 'Select a device (WiFi/Bluetooth)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.devices),
                        ),
                        items: availableDevices.map((device) {
                          return DropdownMenuItem(
                            value: device,
                            child: Row(
                              children: [
                                Icon(
                                  device.contains('WiFi')
                                      ? Icons.wifi
                                      : Icons.bluetooth,
                                  size: context.fontPct(0.02),
                                ),
                                SizedBox(width: context.widthPct(0.02)),
                                Text(device),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsViewModel>().handleIntent(
                                  SaveSelectedDeviceIntent(value),
                                );
                          }
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          final viewModel = context.read<SettingsViewModel>();
                          if (viewModel.canNavigateToWebView()) {
                            Navigator.pushNamed(context, PagesRoute.webview);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a URL first'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: context.heightPct(0.02)),
                        ),
                        child: const Text('Open Web View'),
                      ),
                      SizedBox(height: context.heightPct(0.02)),
                    ],
                  ),
                );
              },
              saving: () => const Center(child: CircularProgressIndicator()),
              saved: () => const SizedBox.shrink(),
              failure: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: context.heightPct(0.02)),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SettingsViewModel>().handleIntent(
                              const LoadSettingsIntent(),
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

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}

