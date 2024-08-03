import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/ui/cubit/navigation%20cubits/navigation_bloc.dart';
import 'package:myapp/ui/views/registration_page_dart.dart';
import 'home_page.dart';

class MyBottomNavigation extends StatelessWidget {
  MyBottomNavigation({Key? key}) : super(key: key);

  final List<Widget> pages = [
    HomePage(),
    RegistrationPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Row(
              children: [],
            )
          ],
        ),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return pages[state.selectedIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
              ],
              currentIndex: state.selectedIndex,
              onTap: (index) {
                context.read<NavigationBloc>().add(NavigateToPage(index));
              },
              backgroundColor: Colors.blue,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.black,
            );
          },
        ),
      ),
    );
  }
}
