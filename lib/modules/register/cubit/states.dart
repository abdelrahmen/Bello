abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  //34an azhero 3ala el screen
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {
  //34an azhero 3ala el screen
  final String error;

  SocialCreateUserErrorState(this.error);
}

class SocialChangePassVisibilityState extends SocialRegisterStates{}