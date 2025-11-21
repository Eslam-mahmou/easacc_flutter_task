import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> loginWithFacebook();
}




