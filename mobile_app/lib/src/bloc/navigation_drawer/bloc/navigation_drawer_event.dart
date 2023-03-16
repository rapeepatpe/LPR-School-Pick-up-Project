part of 'navigation_drawer_bloc.dart';

abstract class NavigationDrawerEvent extends Equatable {
  const NavigationDrawerEvent();

  @override
  List<Object> get props => [];
}

class NavigationDrawerEventSelectHome extends NavigationDrawerEvent {}

class NavigationDrawerEventSelectProfile extends NavigationDrawerEvent {}

class NavigationDrawerEventEditProfile extends NavigationDrawerEvent {}

class NavigationDrawerEventSelectReport extends NavigationDrawerEvent {}