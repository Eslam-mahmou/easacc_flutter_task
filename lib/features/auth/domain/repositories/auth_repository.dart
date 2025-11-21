import '../../../../core/common/result.dart';
import '../entities/user_entity.dart';
import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Result<UserEntity, Failure>> loginWithGoogle();
  Future<Result<UserEntity, Failure>> loginWithFacebook();
}




