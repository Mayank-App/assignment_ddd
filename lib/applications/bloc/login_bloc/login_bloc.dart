import 'dart:async';
import 'package:assignment_ddd/applications/bloc/login_bloc/login_event.dart';
import 'package:assignment_ddd/applications/bloc/login_bloc/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/reposistory/auth_reposistory.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  AuthReposistory authReposistory = AuthReposistory();
  bool isObx = true;
  bool?res;
  LoginBloc():super(IntialState()){
    on<SucessLoginEvent>(login);
    on<ShowPasswordEvent>(showPassword);
  }

  FutureOr<void> login(SucessLoginEvent event, Emitter<LoginState> emit) async{
    res =     await authReposistory.loginUsingEmailAndPassword(event.email,event.password);
    if(res==true){
      emit(SucessLoginState());
    }
    else{
      emit(ErrorLoginState(error: "Enter Correct Credential's"));
    }
  }

  FutureOr<void> showPassword(ShowPasswordEvent event, Emitter<LoginState> emit) {
    isObx =! isObx;
    emit(ShowPasswordState());
    debugPrint(isObx.toString());
  }
}