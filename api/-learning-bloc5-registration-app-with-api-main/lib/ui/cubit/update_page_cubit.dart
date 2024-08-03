import 'package:myapp/data/repositories/person_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePageCubit extends Cubit<void>{
  UpdatePageCubit() : super(0);
  var personRepo = PersonRepository();
  Future<void> updatePerson(int id, String name, String phone) async {
    await personRepo.updatePerson(id, name, phone);
  }
}

