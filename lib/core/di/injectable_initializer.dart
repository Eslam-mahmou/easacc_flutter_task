import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injectable_initializer.config.dart';
import '../../features/auth/presentation/ViewModel/auth_viewmodel.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  // Initialize injectable dependencies
  getIt.init();
  
  // Ensure AuthViewModel is registered (manual fallback)
  if (!getIt.isRegistered<AuthViewModel>()) {
    getIt.registerFactory<AuthViewModel>(
      () => AuthViewModel(getIt<LoginUseCase>()),
    );
  }
}
