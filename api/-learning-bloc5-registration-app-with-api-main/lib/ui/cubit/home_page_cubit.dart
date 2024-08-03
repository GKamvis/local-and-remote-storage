import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/repositories/person_dao.dart';

class HomePageCubit extends Cubit<List<PersonDao>> {
  HomePageCubit() : super([]);
  var personRepo = PersonRepository();

  Future<void> getPerson() async {
    try {
      final person = await personRepo.getPerson();
      print("Persons fetched: $person"); // Debug print
      emit(person);
    } catch (e) {
      print("Error fetching persons: $e"); // Debug print
    }
  }

  Future<void> deletePerson(int id) async {
    await personRepo.deletePerson(id);
    getPerson();
  }

  Future<void> findPerson(String query) async {
    var res = await personRepo.findPerson(query);
    print("Persons found: $res"); // Debug print
    emit(res);
  }
}
