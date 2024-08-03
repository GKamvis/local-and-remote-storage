import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/repositories/person_dao.dart';

class RegistrationPageCubit extends Cubit<void> {
  RegistrationPageCubit() : super(0);

  var personRepo = PersonRepository();
  Future<void> addPerson(String name , String phone) async {
    await personRepo.addPerson(name, phone);
  }
}
