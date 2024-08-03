import 'package:myapp/sqflite/db_helper.dart';

class PersonDao {
  int id;
  String name;
  String phone;
  PersonDao({required this.id, required this.name, required this.phone});
}

class PersonRepository {
  Future<List<PersonDao>> getPerson() async {
    var db = await DbHelper.openDb();
    List<Map<String, dynamic>> personMap =
        await db.rawQuery('SELECT * FROM registration');
    return List.generate(
      personMap.length,
      (i) {
        var row = personMap[i];
        return PersonDao(id: row['id'], name: row['name'], phone: row['phone']);
      },
    );
  }

  Future<void> addPerson(String name, String phone) async {
    var db = await DbHelper.openDb();

    var data = Map<String, dynamic>();
    data['name'] = name;
    data['phone'] = phone;

    await db.insert('registration', data);
  }


  Future<void> deletePerson(int id) async {
    var db = await DbHelper.openDb();
    await db.delete('registration', where: 'id = ?', whereArgs: [id]);
  }


  
  Future<void> updatePerson( int id, String name, String phone) async {
    var db = await DbHelper.openDb();
    var data = Map<String, dynamic>();
    data['name'] = name;
    data['phone'] = phone;
    await db.update('registration', data, where: 'id = ?', whereArgs: [id]);
  }

Future<List<PersonDao>> findPerson(String query) async {
  var db = await DbHelper.openDb();
  List<Map<String, dynamic>> personMap =
      await db.rawQuery("SELECT * FROM registration WHERE name LIKE '%$query%'");
  return List.generate(
    personMap.length,
    (i) {
      var row = personMap[i];
      return PersonDao(id: row['id'], name: row['name'], phone: row['phone']);
    },
  );
}




}
