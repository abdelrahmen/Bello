abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String? uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  //34an azhero 3ala el screen
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialChangePassVisibilityState extends SocialLoginStates {}
