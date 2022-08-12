import 'package:bello/layout/cubit/cubit.dart';
import 'package:bello/layout/social_layout.dart';
import 'package:bello/modules/login/login_screen.dart';
import 'package:bello/shared/constants.dart';
import 'package:bello/shared/network/local/cache_helper.dart';
import 'package:bello/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget widget = LoginScreen();
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = SocialHomeScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()..getUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget,
      ),
    );
  }
}
