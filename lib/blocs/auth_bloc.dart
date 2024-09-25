import 'package:expense_tracker/models/auth_model.dart';
import 'package:expense_tracker/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:expense_tracker/models/login_model.dart';

class AuthBloc {
  final Repository repository = Repository();

  final PublishSubject<AuthModel> _authFetcher = PublishSubject<AuthModel>();

  AuthBloc() {
    isLoggedIn();
  }

  isLoggedIn() async {
    bool isLoggedIn = repository.isLoggedIn();
    _authFetcher.sink.add(AuthModel(isLoggedIn: isLoggedIn));
  }

  login(String username, String password) async {
    return await repository.login(
      LoginModel(username: username, password: password),
    );
  }
}

final authBloc = AuthBloc();
