import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class CardFeedCliente extends StatelessWidget {
  const CardFeedCliente({super.key, required this.card, required this.index});

  final Map<String, String> card;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              TitleCardClient(titulo: card["titulo"]!, avatar: card["avatar"]!),
              const SizedBox(height: 10),
              ImageCardClient(imagen: card["imagen"]!),
              const SizedBox(height: 10),
              LikesCardClient(index: index),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
