/*
Форма аватара
 */



import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  final String avatar;
  final String name;
  final String timeOfReceipt;

  final VoidCallback onPress;
  const MyAvatar({
    Key? key,
    required this.avatar, required this.onPress, required this.name, required this.timeOfReceipt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap:  onPress,
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 5 ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 41,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(avatar)),
                ),
              const SizedBox(
                width: 30,
              ),
              Expanded(child: Text( name, style: const TextStyle(fontSize: 20))),
            ],
          ),
        ),
      ),
    );
  }
}
