import 'package:injectable/injectable.dart';

import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Result<UserEntity, Failure>> call() async {
    return await repository.loginWithFacebook();
  }
  Future<Result<UserEntity, Failure>> invoke() async {
    return await repository.loginWithGoogle();
  }
}

