import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/common/result.dart';
import '../../../../core/error/failure.dart';
import '../datasources/auth_remote_datasource.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<UserEntity, Failure>> loginWithGoogle() async {
    try {
      final user = await _remoteDataSource.loginWithGoogle();
      return Success(user);
    } catch (e) {
      return Error(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Result<UserEntity, Failure>> loginWithFacebook() async {
    try {
      final user = await _remoteDataSource.loginWithFacebook();
      return Success(user);
    } catch (e) {
      return Error(ServerFailure(errorMessage: e.toString()));
    }
  }
}
