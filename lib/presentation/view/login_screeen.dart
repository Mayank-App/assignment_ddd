import 'package:assignment_ddd/applications/bloc/login_bloc/login_bloc.dart';
import 'package:assignment_ddd/applications/bloc/login_bloc/login_event.dart';
import 'package:assignment_ddd/applications/bloc/login_bloc/login_state.dart';
import 'package:assignment_ddd/domain/reposistory/auth_reposistory.dart';
import 'package:assignment_ddd/utils/routes/routes_imports.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../resources/app_color.dart';
import '../../resources/components/round_button.dart';
import '../../utils/utils.dart';

@RoutePage()
class SignInScreen extends StatefulWidget{
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {
  LoginBloc loginBloc = LoginBloc();
  bool ?res;
  AuthReposistory authReposistory = AuthReposistory();
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode loginFocus = FocusNode();
  ValueNotifier<bool> obscurePassword= ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: BlocConsumer<LoginBloc,LoginState>(
          bloc: loginBloc,
          builder: (BuildContext context, LoginState state){
            return Container(
                height: double.infinity ,
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                      child:Form(
                        key: _formKey,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Image.asset("assets/images/signup_image.avif",scale: 4,),
                              ),
                              Text("Welcome Back!",style:  TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold
                              ),),
                              const SizedBox(height: 5,),
                              Text("Login in to your existant account ",style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              const SizedBox(height: 50,),
                              Column(
                                children: [
                                  TextFormField(
                                    controller: email,
                                    focusNode: emailFocus,
                                    keyboardType: TextInputType.emailAddress,
                                    onFieldSubmitted: (val1){
                                      Utils.fieldFocusNode(context, emailFocus,passwordFocus);
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                      prefixIcon:  Icon(
                                        Icons.email,
                                        color: Colors.blue,
                                      ),
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black26,

                                        ),
                                      ),
                                      focusedBorder:
                                      OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.blueAccent,
                                              width: 2
                                          )
                                      ),

                                    ),
                                    validator: Utils.isValidEmail,
                                  ),
                                  const SizedBox(height: 20,),
                                  TextFormField(
                                      controller: password,
                                      focusNode: passwordFocus,
                                      keyboardType: TextInputType.text,
                                      validator: Utils.isValidPass,
                                      onFieldSubmitted: (val1){
                                        Utils.fieldFocusNode(context, passwordFocus,loginFocus);
                                      },
                                       obscureText: loginBloc.isObx,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                        prefixIcon:  Icon(
                                          Icons.lock,
                                          color:Colors.blue,
                                        ),
                                        hintText: 'Password',

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black26,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                color: Colors.blueAccent,
                                                width: 2
                                            )
                                        ),
                                        suffixIcon: IconButton(onPressed: (){
                                          loginBloc.add(ShowPasswordEvent());
                                        }, icon:Icon(Icons.change_circle,color: Colors.purple,)),
                                      )
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(onPressed: (){
                                        //Navigator.pushNamed(context, RoutesName.forgetPassword);
                                      }, child:Text("Forget Password",style: TextStyle(
                                          color:Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold
                                      ),))),
                                  const SizedBox(height: 10,),
                                  RoundButton(
                                    // loading: val.loading,
                                      focusNode: loginFocus
                                      ,text: "LogIn", onPress: () async{
                                    Utils.hideKeyboard(context);
                                    if (_formKey.currentState!.validate()) {
                                     loginBloc.add(SucessLoginEvent(email: email.text.trim().toString(),password: password.text.trim().toString()));
                                    }
                                  }, color:AppColors.blue),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text("Don't have an account? ",style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  InkWell(
                                      onTap:  (){
                                        AutoRouter.of(context).push( const SignUpScreenRoute() );
                                      },
                                      child: Text("Sign Up",style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold
                                      ),)),
                                ],
                              )


                            ],
                          ),
                        ),

                      )
                  ),
                )
            );
          },
          listener: (BuildContext context, LoginState state) {
           if(state is SucessLoginState){
             Utils.toastMessage("Login Sucess");
             AutoRouter.of(context).push( const HomeScreenRoute() );;
           }
           if(state is ErrorLoginState){
             Utils.toastMessage(state.error);
           }
          },),
      );
  }
}


