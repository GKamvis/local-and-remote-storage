import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/repositories/person_dao.dart';

class HomePageCubit extends Cubit<List<PersonDao>> {
  HomePageCubit() : super([]);
  var personRepo = PersonRepository();

  Future<void> getPerson() async {
    emit(await personRepo.getPerson());
  }

  Future<void> deletePerson(int id) async {
    await personRepo.deletePerson(id);
    getPerson();
  }

  Future<void> findPerson(String query) async {
    var res = await personRepo.findPerson(query);
    emit(res);
  }
}
