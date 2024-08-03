import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/ui/cubit/home_page_cubit.dart';

import '../../data/repositories/person_dao.dart';
import '../cubit/search/search_Repo_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()..getPerson()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<SearchCubit, bool>(
            builder: (context, showSearch) {
              return showSearch
                  ? TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                      ),
                      onChanged: (newQuery) {
                        if (newQuery.isEmpty) {
                          context.read<HomePageCubit>().getPerson();
                          return;
                        }
                        context.read<HomePageCubit>().findPerson(newQuery);
                      },
                    )
                  : Text('Home Page');
            },
          ),
          actions: [
            BlocBuilder<SearchCubit, bool>(
              builder: (context, showSearch) {
                return IconButton(
                  onPressed: () {
                    context.read<SearchCubit>().toggleSearch();
                    if (!showSearch) {
                      context.read<HomePageCubit>().getPerson();
                    }
                  },
                  icon: showSearch ? Icon(Icons.cancel) : Icon(Icons.search),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomePageCubit, List<PersonDao>>(
          builder: (context, people) {
            print("People list: $people"); // Debug print
            if (people.isNotEmpty) {
              return ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  var person = people[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/update', arguments: person)
                          .then((_) {
                        context.read<HomePageCubit>().getPerson();
                      });
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(person.name),
                          Text(person.phone),
                          SizedBox(height: 50),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<HomePageCubit>()
                                  .deletePerson(int.parse(person.id));
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No results found.'),
              );
            }
          },
        ),
      ),
    );
  }
}
