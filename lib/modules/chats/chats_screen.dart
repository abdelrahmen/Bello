import 'package:bello/layout/cubit/cubit.dart';
import 'package:bello/layout/cubit/states.dart';
import 'package:bello/modules/chat_details/chat_details_screen.dart';
import 'package:bello/shared/components.dart';
import 'package:bello/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (SocialCubit.get(context).users.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    context, SocialCubit.get(context).users[index]),
                separatorBuilder: (context, index) => mySeparator(),
                itemCount: SocialCubit.get(context).users.length,
              );
      },
    );
  }

  Widget buildChatItem(context, model) => InkWell(
        onTap: () {
          navigateTO(context, ChatDetailsScreens(user: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              //profile photo
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              //name , check mark & date
              Text('${model.name}'), //three dots
            ],
          ),
        ),
      );
}
