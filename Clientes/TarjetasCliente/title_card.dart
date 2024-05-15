import 'package:flutter/material.dart';

class TitleCardClient extends StatelessWidget {
  const TitleCardClient(
      {super.key, required this.avatar, required this.titulo});

  final String titulo;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CircleAvatar(
              child: Text(
            avatar,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          )),
          const SizedBox(width: 5),
          Text(titulo,
              style: const TextStyle(
                color: Color.fromARGB(255, 149, 141, 141),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))
        ]));
  }
}
