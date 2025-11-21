import 'package:esacc_flutter_task/features/auth/presentation/View/widget/cutom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/routes/pages_route.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../../../core/widget/custom_dialog.dart';
import '../ViewModel/auth_viewmodel.dart';
import '../ViewModel/auth_intent.dart';
import '../ViewModel/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthViewModel>(),
      child: Scaffold(
        body: BlocConsumer<AuthViewModel, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              EasyLoading.show();
            }
            if (state is AuthSuccessState) {
              EasyLoading.dismiss();
              DialogUtils.showMessage(
                context: context,
                message: "Login Successfully",
                title: "Success",
                postActionName: "Ok"
              );
            }
            if (state is AuthErrorState) {
              EasyLoading.dismiss();
              DialogUtils.showMessage(
                context: context,
                message: state.errMessage,
                title: "Error",
                negativeActionName: "Cancel",
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(context.widthPct(0.1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Easacc Task',
                    style: TextStyle(
                      fontSize: context.fontPct(0.06),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: context.heightPct(0.08)),
                  CustomLoginButton(
                    text: 'Login with Google',
                    color: Colors.red,
                    icon: Icons.g_mobiledata,
                    onPressed: () => context
                        .read<AuthViewModel>()
                        .handleIntent(const LoginWithGoogleIntent()),
                  ),
                  SizedBox(height: context.heightPct(0.02)),
                  CustomLoginButton(
                    text: 'Login with Facebook',
                    color: const Color(0xFF1877F2),
                    icon: Icons.facebook,
                    onPressed: () => context
                        .read<AuthViewModel>()
                        .handleIntent(const LoginWithFacebookIntent()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
