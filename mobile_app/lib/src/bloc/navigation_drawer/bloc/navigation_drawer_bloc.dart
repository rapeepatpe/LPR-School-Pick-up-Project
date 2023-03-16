import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_drawer_event.dart';
part 'navigation_drawer_state.dart';

class NavigationDrawerBloc
    extends Bloc<NavigationDrawerEvent, NavigationDrawerState> {
  NavigationDrawerBloc() : super(NavigationDrawerStateHome()) {
    on<NavigationDrawerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
