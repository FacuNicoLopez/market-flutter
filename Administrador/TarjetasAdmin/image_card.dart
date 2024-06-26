import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.imagen});

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
