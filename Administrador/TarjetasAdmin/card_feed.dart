import 'package:flutter/material.dart';
import 'package:flutter_csharp3/Administrador/TarjetasAdmin/image_card.dart';
import 'package:flutter_csharp3/Administrador/TarjetasAdmin/likes_card.dart';
import 'package:flutter_csharp3/Administrador/TarjetasAdmin/title_card.dart';

class CardFeed extends StatelessWidget {
  const CardFeed({super.key, required this.card, required this.index});

  final Map<String, String> card;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        width: 400,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 5),
          )
        ], borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        child: Column(
          children: [
            TitleCard(titulo: card["titulo"]!, avatar: card["avatar"]!),
            const SizedBox(height: 10),
            ImageCard(imagen: card["imagen"]!),
            const SizedBox(height: 10),
            LikesCard(index: index),
            const SizedBox(height: 10),
          ],
        ),
      ),
      const SizedBox(height: 10)
    ]);
  }
}
