import 'package:dartz/dartz.dart';
import 'package:campusswift_app/core/errors/failures.dart';
import 'package:campusswift_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
}
