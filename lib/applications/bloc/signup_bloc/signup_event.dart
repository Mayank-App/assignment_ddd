abstract class SignUpEvent{

}

class SucessSignUpEvent extends SignUpEvent{
  final  email;
  final  password;
     SucessSignUpEvent({required this.email , required this.password});
}
class ShowPasswordEvent extends SignUpEvent{
  // final isObx;
  // ShowPasswordEvent({required this.isObx});
}
class ShowConformPasswordEvent extends SignUpEvent{

}