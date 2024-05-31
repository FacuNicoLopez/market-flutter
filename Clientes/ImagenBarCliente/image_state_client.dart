import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

abstract class ImagenStateClient {}

class ImagenInitial extends ImagenStateClient {}

class ImagenLoadedClient extends ImagenStateClient {
  final String mainImageUrlClient;
  final ThemeMode themeModeClient;

  ImagenLoadedClient(
      {required this.mainImageUrlClient, required this.themeModeClient});
}
