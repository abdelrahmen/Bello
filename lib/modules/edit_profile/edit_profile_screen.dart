import 'dart:io';

import 'package:bello/layout/cubit/cubit.dart';
import 'package:bello/layout/cubit/states.dart';
import 'package:bello/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        nameController.text = userModel?.name ?? '';
        bioController.text = userModel?.bio ?? '';
        phoneController.text = userModel?.phone ?? '';

        var profileImage = SocialCubit.get(context).profileImage;
        
        var coverImage = SocialCubit.get(context).coverImage;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            titleSpacing: 5.0,
            title: Text('Edit profile'),
            actions: [
              MaterialButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: Text('UPDATE'),
                textColor: Colors.white,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUpdatUserLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUpdatUserLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  //cover photo
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        //cover photo
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                      image: (coverImage == null)
                                          ? NetworkImage(
                                              '${userModel?.cover}',
                                            )
                                          : FileImage(
                                              File(coverImage.path),
                                            ) as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //profile photo
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).backgroundColor,
                              radius: 64,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: (profileImage == null)
                                    ? NetworkImage(
                                        '${userModel?.image}',
                                      )
                                    : FileImage(
                                        File(profileImage.path),
                                      ) as ImageProvider,
                              ),
                            ),
                            //camera edit button
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //name form field
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'name cannot be empty';
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //bio
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.info_outline,
                      ),
                      label: Text('Bio'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'bio cannot be empty';
                      }
                      return null;
                    },
                    controller: bioController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //phone
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android_outlined,
                      ),
                      label: Text('Phone'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'phone cannot be empty';
                      }
                      return null;
                    },
                    controller: phoneController,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
