import 'package:myapp/data/repositories/person_dao.dart';

class PeopleData {
  List<PersonDao> personDao;
  int success;
  PeopleData({required this.personDao, required this.success});

  factory PeopleData.fromJson(Map<String, dynamic> json) {
    var jsonArray = json['kisiler'] as List;
    int success = json['success'] as int;
    var people = jsonArray
        .map((jsonArrayObjet) => PersonDao.fromJson(jsonArrayObjet))
        .toList();
    print("Parsed PeopleData: $people"); // Debug print
    return PeopleData(personDao: people, success: success);
  }
}
