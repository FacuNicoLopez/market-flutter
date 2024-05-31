import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class ImageCardClient extends StatelessWidget {
  const ImageCardClient({super.key, required this.imagen});

  final String imagen;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      fit: BoxFit.cover,
      height: 250,
      width: double.infinity,
      imagen,
    );
  }
}
