import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;
  GetCurrentUserUseCase(this.repository);

  UserEntity? call() {
    final user = repository.getCurrentUser();
    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
    );
  }
}
