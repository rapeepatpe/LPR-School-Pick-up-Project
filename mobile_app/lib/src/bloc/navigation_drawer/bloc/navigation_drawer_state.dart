part of 'navigation_drawer_bloc.dart';

abstract class NavigationDrawerState extends Equatable {
  const NavigationDrawerState();

  @override
  List<Object> get props => [];
}

class NavigationDrawerStateHome extends NavigationDrawerState {}

class NavigationDrawerStateProfile extends NavigationDrawerState {}

class NavigationDrawerStateEditProfile extends NavigationDrawerState {}

class NavigationDrawerStateReport extends NavigationDrawerState {}


