import 'dart:io';

import 'package:flutter/material.dart';

class MyAvatarPhoto extends StatelessWidget {
 final String avatar;
 final double radiusOut;
 final double radiusIn;

  const MyAvatarPhoto({Key? key, required this.avatar, required this.radiusOut, required this.radiusIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radiusOut,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: radiusIn,
        backgroundImage: FileImage(File(avatar)),
      ),
    );
  }
}
