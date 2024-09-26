import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final Repository repository = Repository();

  final PublishSubject<UserModel> _userFetcher = PublishSubject<UserModel>();

  Stream<UserModel> get user => _userFetcher.stream;

  UserBloc() {
    getUser();
  }

  getUser() async {
    try {
      var user = await repository.getUser();
      _userFetcher.sink.add(UserModel(
        id: user['id'],
        username: user['username'],
        email: user['email'],
        firstName: user['firstName'],
        lastName: user['lastName'],
        gender: user['gender'],
        image: user['image'],
      ));
      
    } catch (e) {
      print(e);
    }
  }
}

final userBloc = UserBloc();
