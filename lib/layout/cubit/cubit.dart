import 'dart:io';
import 'dart:math';

import 'package:bello/layout/cubit/states.dart';
import 'package:bello/models/message_model.dart';
import 'package:bello/models/post_model.dart';
import 'package:bello/models/user_model.dart';
import 'package:bello/modules/chats/chats_screen.dart';
import 'package:bello/modules/feeds/feeds_screen.dart';
import 'package:bello/modules/new_post/new_post_screen.dart';
import 'package:bello/modules/settings/settings_screen.dart';
import 'package:bello/modules/users/users_screen.dart';
import 'package:bello/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(
        SocialCreateNewPostState(),
      );
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  List<String> titles = [
    'Home',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  bool profileImageUpdated = false;
  XFile? profileImage;
  final ImagePicker picker = ImagePicker();
  Future getProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = XFile(image.path);
      profileImageUpdated = true;
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('nullllllllllllll');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  bool coverImageUpdated = false;
  XFile? coverImage;
  Future getCoverImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverImage = XFile(image.path);
      coverImageUpdated = true;
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('nullllllllllllll');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdatUserLoadingState());
    profileImageUpdated = true;
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage?.path ?? '').pathSegments.last}')
        .putFile(
          File('${profileImage?.path}'),
        )
        .then((value) {
      // emit(SocialUploadProfileImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((onError) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadcoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdatUserLoadingState());
    coverImageUpdated = true;
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage?.path ?? '').pathSegments.last}')
        .putFile(
          File('${coverImage?.path}'),
        )
        .then((value) {
      // emit(SocialUplaodCoverImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((onError) {
        emit(SocialUplaodCoverImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUplaodCoverImageErrorState());
    });
  }

  //updateUserData
  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    // emit(SocialUpdatUserLoadingState());
    if (profileImage != null && profileImageUpdated) {
      uploadProfileImage(
        name: name,
        phone: phone,
        bio: bio,
      );
      profileImageUpdated = false;
    }
    if (coverImage != null && coverImageUpdated) {
      uploadcoverImage(
        name: name,
        phone: phone,
        bio: bio,
      );
      coverImageUpdated = false;
    }
    UserModel model = UserModel(
      name: name,
      email: userModel?.email,
      uId: userModel?.uId,
      phone: phone,
      bio: bio,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocialUpdatUserErrorState());
    });
  }

  XFile? postImage;
  Future getPostImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      postImage = XFile(image.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('postImage is nullllllllllllll');
      emit(SocialPostImagePickedErrorState());
    }
  }

  //createNewPost
  bool postImageUploaded = false;
  void uploadPostImage({
    required dateTime,
    required text,
  }) {
    emit(SocialCreatePostLoadingState());
    // postImageUploaded = true;
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage?.path ?? '').pathSegments.last}')
        .putFile(
          File('${postImage?.path}'),
        )
        .then((value) {
      // emit(SocialUplaodCoverImageSuccessState());
      value.ref.getDownloadURL().then((value) {
        print(value);
        createNewPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((onError) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createNewPost({
    required dateTime,
    required text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        }).catchError((onError) {
          print(onError);
        });
      });
    }).catchError((onError) {
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc('${userModel?.uId}')
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((onError) {
      emit(SocialLikePostErrorState(onError.toString()));
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    if (users.isEmpty)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel?.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((onError) {
        emit(SocialGetAllUsersErrorState(onError.toString()));
      });
  }

  void sendMessage({
    required String? recieverId,
    required String? dateTime,
    required String? text,
  }) {
    MessageModel message = MessageModel(
      senderId: userModel?.uId,
      recieverId: recieverId,
      dateTime: dateTime,
      text: text,
    );
    //sender
    FirebaseFirestore.instance
        .collection('users')
        .doc('${userModel?.uId}')
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
    //reciever
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc('${userModel?.uId}')
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String? recieverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
