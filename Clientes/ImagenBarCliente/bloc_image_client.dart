import 'package:flutter_csharp3/Clientes/screen_view_client.dart';

class ImagenBlocClient extends Bloc<ImagenEventClient, ImagenStateClient> {
  ImagenBlocClient()
      : super(ImagenLoadedClient(
          mainImageUrlClient:
              'https://img.freepik.com/foto-gratis/fondo-degradado-abstracto-borde-azul_53876-104041.jpg',
          themeModeClient: ThemeMode.light,
        )) {
    on<ToggleImagenThemeEvent>((event, emit) {
      final currentState = state as ImagenLoadedClient;
      emit(ImagenLoadedClient(
        mainImageUrlClient: currentState.themeModeClient == ThemeMode.dark
            ? 'https://img.freepik.com/foto-gratis/fondo-degradado-abstracto-borde-azul_53876-104041.jpg'
            : 'https://img.freepik.com/foto-gratis/fondo-decorativo-humo_23-2147611841.jpg',
        themeModeClient: currentState.themeModeClient == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark,
      ));
    });
  }
}
