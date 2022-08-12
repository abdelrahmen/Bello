import 'package:bello/layout/cubit/cubit.dart';
import 'package:bello/layout/cubit/states.dart';
import 'package:bello/models/message_model.dart';
import 'package:bello/models/user_model.dart';
import 'package:bello/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreens extends StatelessWidget {
  UserModel user;
  ChatDetailsScreens({Key? key, required this.user}) : super(key: key);
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(recieverId: user.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${user.image}'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text('${user.name}'),
                ],
              ),
            ),
            body: (SocialCubit.get(context).messages.isEmpty)
                ? const Text('EMPTY')
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index){
                                var message = SocialCubit.get(context).messages[index];
                                if (SocialCubit.get(context).userModel?.uId==message.senderId) {
                                  return buildMyMessage(message);
                                }
                                return buildMessage(message);
                              } ,
                              separatorBuilder: (context, index) => SizedBox(height: 15),
                              itemCount:  SocialCubit.get(context).messages.length,
                              ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                //message form field
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Message'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: defaultColor,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                      recieverId: user.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                  },
                                  child: Icon(
                                    Icons.send_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(8),
                bottomStart: Radius.circular(8),
                bottomEnd: Radius.circular(8),
              )),
          child: Text('${message.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(8),
              bottomStart: Radius.circular(8),
              bottomEnd: Radius.circular(8),
            ),
          ),
          child: Text('${message.text}'),
        ),
      );
}
