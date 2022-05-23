// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.name,
    required this.surname,
    required this.last_message,
    required this.last_time,
    //required this.chat,
    required this.press,
    required this.last_uid,
    required this.user_uid,
    required this.readed,
  }) : super(key: key);

  //final Chat chat;
  final VoidCallback press;
  final String name;
  final String surname;
  final String last_message;
  final String last_time;
  final String user_uid;
  final String last_uid;
  final bool readed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          /*borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))*/
          color: readed == false
              ? kappLightDarkenColor.withOpacity(0.6)
              : kappDarkenColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
                  ),
                  if (readed != true)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: kappDarkenColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                      ),
                    )
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.toString() + " " + surname.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          last_uid != user_uid
                              ? last_message
                              : "You : $last_message",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: 0.64,
                child: Text(
                  last_time,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
