import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/ui/cubit/home_page_cubit.dart';
import 'package:myapp/ui/cubit/registration_page_cubit.dart';
import 'package:myapp/ui/cubit/search/search_Repo_cubit.dart';
import 'package:myapp/ui/cubit/update_page_cubit.dart';
import 'package:myapp/ui/views/bottom_navigation.dart';
import 'package:myapp/ui/views/update_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => HomePageCubit()),
        BlocProvider(create: (_) => RegistrationPageCubit()),
        BlocProvider(create: (_) => UpdatePageCubit()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyBottomNavigation(),
        routes: {
          '/update': (context) => UpdatePage(),
          '/home': (context) => MyBottomNavigation(),
          '/bottomnavigation' : (context) => MyBottomNavigation()
        },
      ),
    );
  }
}
