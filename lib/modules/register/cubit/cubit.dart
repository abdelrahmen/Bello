import 'package:bello/models/user_model.dart';
import 'package:bello/modules/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user?.uid,
      );
      print(value.user?.email);
      print(value.user?.uid);
      emit(SocialRegisterSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(SocialRegisterErrorState(onError.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String? uId,
  }) {
    emit(SocialRegisterLoadingState());
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://img.freepik.com/free-photo/happy-bearded-young-man-looks-with-joyful-expression-has-friendly-smile-wears-yellow-sweater-red-hat_295783-1388.jpg?w=1060&t=st=1659186116~exp=1659186716~hmac=1ec609c10ea5cb15e56ded28777fe50038206f541adfa2e484cbdde411c94f35',
      cover:
          'https://img.freepik.com/free-photo/happy-bearded-young-man-looks-with-joyful-expression-has-friendly-smile-wears-yellow-sweater-red-hat_295783-1388.jpg?w=1060&t=st=1659186116~exp=1659186716~hmac=1ec609c10ea5cb15e56ded28777fe50038206f541adfa2e484cbdde411c94f35',
      bio: 'write your bio ...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(SocialCreateUserErrorState(onError.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool hidden = true;
  void changePassVissibitlty() {
    hidden = !hidden;
    suffixIcon =
        hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePassVisibilityState());
  }
}
