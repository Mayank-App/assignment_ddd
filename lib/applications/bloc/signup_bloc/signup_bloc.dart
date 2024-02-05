import 'dart:async';

import 'package:assignment_ddd/applications/bloc/signup_bloc/signup_event.dart';
import 'package:assignment_ddd/applications/bloc/signup_bloc/signup_state.dart';
import 'package:assignment_ddd/domain/reposistory/auth_reposistory.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/utils.dart';

class SignupBloc extends Bloc<SignUpEvent,SignupState>{
  AuthReposistory authReposistory = AuthReposistory();
  bool?res;
  bool isObx = true;
  bool isObxConform = true;
  SignupBloc():super(IntialState()){
    on<SucessSignUpEvent>(signup);
    on<ShowPasswordEvent>(showPassword);
    on<ShowConformPasswordEvent>(showConformPassword);

  }
  FutureOr<void> signup(SucessSignUpEvent event, Emitter<SignupState> emit) async{
    res =     await authReposistory.registerUserWithEmailPassword(event.email,event.password);
      debugPrint(event.email.toString());
      debugPrint(event.password.toString());
    if(res==true){
      emit(SucessSignUpState());
    }
    else{
      emit(ErrorSignUpState(error: "Enter Correct Email and Password"));
    }
    
  }
  FutureOr<void> showPassword(ShowPasswordEvent event, Emitter<SignupState> emit) {
    isObx = !isObx;
    emit(ShowPasswordState());
    // debugPrint(isObx.toString());
  }

  FutureOr<void> showConformPassword(ShowConformPasswordEvent event, Emitter<SignupState> emit) {
    isObxConform = !isObxConform;
    emit(ShowConFormPasswordState());
    debugPrint(isObxConform.toString());
  }
}