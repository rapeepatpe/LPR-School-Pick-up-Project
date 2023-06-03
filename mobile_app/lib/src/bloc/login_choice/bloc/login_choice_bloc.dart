import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_choice_event.dart';
part 'login_choice_state.dart';

class LoginChoiceBloc extends Bloc<LoginChoiceEvent, LoginChoiceState> {
  LoginChoiceBloc() : super(LoginChoiceInput()) {
    on<LoginChoiceEvent>((event, emit) {
      // TODO: implement event handler

      // อันนี้คือทุก event เดานะ เพราะมัน on Main Event
      print('ทุก event จริงปะ');
    });

    on<LoginChoiceEventSelectInput>((event, emit) {
      // TODO ปรับ เป็นโหมด username
    });

    on<LoginChoiceEventSelectQR>((event,emit) {
      // TODO ปรับ เป็นโหมด QR
    });
  }
}
