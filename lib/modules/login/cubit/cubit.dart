import 'package:bello/modules/login/cubit/states.dart';
import 'package:bello/shared/network/remote/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:electro_market/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
       password: password,
       ).then((value){
        emit(SocialLoginSuccessState(value.user?.uid));
       }).catchError((onError){
        print(onError);
        emit(SocialLoginErrorState(onError.toString()));
       });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool hidden = true;
  void changePassVissibitlty() {
    hidden = !hidden;
    suffixIcon =
        hidden ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(SocialChangePassVisibilityState());
  }
}
