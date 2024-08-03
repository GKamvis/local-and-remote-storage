import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/repositories/person_dao.dart';
import 'package:myapp/ui/cubit/update_page_cubit.dart';

class UpdatePage extends StatelessWidget {
   UpdatePage({super.key});
  @override
  Widget build(BuildContext context) {
      final PersonDao person = ModalRoute.of(context)!.settings.arguments as PersonDao;
      final TextEditingController nameController = TextEditingController(text: person.name);
      final TextEditingController phoneController = TextEditingController(text: person.phone);

          return  Scaffold(
      appBar: AppBar(
        title: const Text('Update Page'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: nameController,decoration: InputDecoration(border:OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20),)),hintText: 'update  your name',)),  
              TextField(controller: phoneController,decoration: InputDecoration(border:OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20),)),hintText: 'update your name',)),   
              ElevatedButton(onPressed: () {
                context.read<UpdatePageCubit>().updatePerson(int.parse(person.id), nameController.text, phoneController.text);
              }, child: const Text('update'))
            ],
          )
        ),
      ),
    );
  }
}