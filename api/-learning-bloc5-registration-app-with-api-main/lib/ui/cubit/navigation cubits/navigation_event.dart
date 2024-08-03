part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPage extends NavigationEvent {
  final int index;

  const NavigateToPage(this.index);

  @override
  List<Object> get props => [index];
}
