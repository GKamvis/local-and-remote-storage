import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/People_data.dart';

class PersonDao {
  String id;
  String name;
  String phone;
  PersonDao({required this.id, required this.name, required this.phone});

  factory PersonDao.fromJson(Map<String, dynamic> json) {
    return PersonDao(
        id: json['kisi_id'] as String,
        name: json['kisi_ad'] as String,
        phone: json['kisi_tel'] as String);
  }
}

class PersonRepository {
  List<PersonDao> parsePerson(String response) {
    return PeopleData.fromJson(json.decode(response)).personDao;
  }

  Future<void> addPerson(String name, String phone) async {
    var url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php";
    var data = <String, dynamic>{};
    data['kisi_ad'] = name;
    data['kisi_tel'] = phone;
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print(response.data.toString());
  }

  Future<List<PersonDao>> getPerson() async {
    var url = 'http://kasimadalan.pe.hu/kisiler/tum_kisiler.php';
    var response = await Dio().get(url);
    print("API response data: ${response.data}"); // Debug print
    var parsedData = parsePerson(response.data.toString());
    print("Parsed Data: $parsedData"); // Debug print
    return parsedData;
  }

  Future<void> deletePerson(int id) async {
    var url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php";
    var data = <String, dynamic>{};
    data['kisi_id'] = id;
    var response = await Dio().post(url, data: FormData.fromMap(data));
  }

  Future<void> updatePerson(int id, String name, String phone) async {
    var url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php";
    var data = <String, dynamic>{};
    data['kisi_id'] = id;
    data['kisi_ad'] = name;
    data['kisi_tel'] = phone;
    var response = await Dio().post(url, data: FormData.fromMap(data));
  }

  Future<List<PersonDao>> findPerson(String query) async {
    var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php";
    var data = <String, dynamic>{};
    data["kisi_ad"] = query;
    var response = await Dio().post(url, data: FormData.fromMap(data));
    return parsePerson(response.data.toString());
  }
}
