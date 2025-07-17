import 'package:dartz/dartz.dart';
import 'package:campusswift_app/core/errors/failures.dart';
import 'package:campusswift_app/features/auth/domain/entities/user_entity.dart';
import 'package:campusswift_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:campusswift_app/features/auth/data/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final firebaseUser = await remoteDataSource.signInWithGoogle();
      // Convert Firebase User to our UserEntity
      final userEntity = UserEntity(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
      return Right(userEntity);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
