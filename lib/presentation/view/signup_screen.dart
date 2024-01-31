
import 'package:assignment_ddd/applications/bloc/signup_bloc/signup_bloc.dart';
import 'package:assignment_ddd/applications/bloc/signup_bloc/signup_event.dart';
import 'package:assignment_ddd/applications/bloc/signup_bloc/signup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../domain/reposistory/auth_reposistory.dart';
import '../../resources/app_color.dart';
import '../../resources/app_string.dart';
import '../../resources/app_style.dart';
import '../../resources/components/round_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';


class SignUpScreen extends StatefulWidget{
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignupBloc signupBloc =SignupBloc();
  bool?res;
  bool isObx = false;
  AuthReposistory authReposistory = AuthReposistory();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword= TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode conformFocus = FocusNode();
  FocusNode signupFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back_outlined),
          //replace with our own icon data.
        ),
      ),
      body:  BlocConsumer<SignupBloc,SignupState>(
        bloc:signupBloc ,
        builder: (BuildContext context, SignupState state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppString.signUpHeader,style: AppStyle.BlackBoldNormal24(),),
                SizedBox(height: 5,),
                Text(AppString.signUpitle1,style: AppStyle.GreyBoldNormal14(),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                  child: Form(
                      key: _formKey,
                      child : Column(
                        children: [
                          TextFormField(
                            controller: name,
                            focusNode: nameFocus,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (val1){
                              Utils.fieldFocusNode(context, nameFocus,emailFocus);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                              prefixIcon:  Icon(
                                Icons.person,
                                color: AppColors.blue,
                              ),
                              hintText: 'Full Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: AppColors.black26,

                                ),
                              ),
                              focusedBorder:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: AppColors.blueAccent,
                                      width: 2
                                  )
                              ),

                            ),
                            validator: Utils.isValidName,
                          ),
                          const SizedBox(height: 20,),
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
                                color: AppColors.blue,
                              ),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: AppColors.black26,

                                ),
                              ),
                              focusedBorder:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: AppColors.blueAccent,
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
                                Utils.fieldFocusNode(context, passwordFocus,conformFocus);
                              },
                               obscureText:signupBloc.isObx?false:true ,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                prefixIcon:  Icon(
                                  Icons.lock,
                                  color: AppColors.blue,
                                ),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: AppColors.black26,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.blueAccent,
                                        width: 2
                                    )
                                ),
                                suffixIcon: IconButton(onPressed: (){
                                  signupBloc.add(ShowPasswordEvent());
                                }, icon:Icon(Icons.change_circle,color: Colors.purple,)),
                              )
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                              controller: conformPassword,
                              focusNode: conformFocus,
                              keyboardType: TextInputType.text,
                              validator: Utils.isValidPass,
                              onFieldSubmitted: (val1){
                                Utils.fieldFocusNode(context, conformFocus,signupFocus);
                              },
                               obscureText: signupBloc.isObxConform,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                prefixIcon:  Icon(
                                  Icons.lock,
                                  color: AppColors.blue,
                                ),
                                hintText: 'Conform Password',

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: AppColors.black26,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.blueAccent,
                                        width: 2
                                    )
                                ),
                                suffixIcon: IconButton(onPressed: (){
                                 signupBloc.add(ShowConformPasswordEvent());
                                }, icon:Icon(Icons.change_circle,color: Colors.purple,)),
                              )
                          ),
                          SizedBox(height: 30,),
                          RoundButton(
                            // loading: valueloading,
                              focusNode: signupFocus
                              ,text: AppString.signUpText, onPress: () async{
                            Utils.hideKeyboard(context);

                            if (_formKey.currentState!.validate()) {
                              if(password.text.trim().toString() == conformPassword.text.trim().toString()){
                                // value.setLoading(true);
                                // value.signup(context);
                               signupBloc.add(SucessSignUpEvent(email: email.text.trim().toString(), password: password.text.trim().toString()));
                              }
                              else
                              {
                                 Utils.toastMessage("Password and conform Passsword not same ");
                              }
                            }

                          }, color:AppColors.blue),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppString.signUpFooterTitle,style: AppStyle.GreyBoldNormal14(),),
                              InkWell(
                                  onTap:  (){
                                    Navigator.pushNamed(context, RoutesName.login);
                                  },
                                  child: Text(AppString.logIn,style: AppStyle.BlueAccrentBoldNormal14(),)),
                            ],
                          )
                        ],

                      )
                  ),
                )
              ],
            ),
          );

        },
        listener: (BuildContext context, SignupState state) {
          if(state is SucessSignUpState){
            Utils.toastMessage("SignUp Sucess");
            Navigator.pushNamed(context, RoutesName.login);
          }
          if(state is ErrorSignUpState){
            Utils.toastMessage(state.error);
          }
        },

    )

    ,
    );
  }
}