import 'package:bello/layout/cubit/cubit.dart';
import 'package:bello/layout/cubit/states.dart';
import 'package:bello/models/post_model.dart';
import 'package:bello/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (SocialCubit.get(context).posts.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          //photo + communicate with your friends
                          Image(
                            image: NetworkImage(
                              'https://img.freepik.com/free-photo/orange-hat-cute-young-guy-orange-shirt-with-hat-praying-smiling_140725-163603.jpg?w=1060&t=st=1659128832~exp=1659129432~hmac=a8dc172e2dafa67abbde0fbc6b55f4468f008e607ae5a43eddb0a09c0a12b5cf',
                            ),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with your friends',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          context, SocialCubit.get(context).posts[index], index),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: SocialCubit.get(context).posts.length,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget buildPostItem(context, PostModel model, index) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //profile photo
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${SocialCubit.get(context).userModel?.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  //name , check mark & date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //name & check mark
                        Row(
                          children: [
                            Text('${model.name}'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            )
                          ],
                        ),
                        //date and time
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  //three dots
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 18,
                    ),
                  ),
                ],
              ),
              //separator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              //hashtag text
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Container(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#hashtag',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#hashtag2',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#averylooooooooooooooooonghashtag',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //photo of post
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(
                            '${model.postImage}',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              //likes and comments
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '1200',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.comment_outlined,
                                size: 16,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              //separator
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              //comment like share
              Row(
                children: [
                  //write a comment
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel?.image}',
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'write a comment',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //like button
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
