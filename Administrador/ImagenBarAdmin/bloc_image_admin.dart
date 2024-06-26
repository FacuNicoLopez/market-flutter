import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

class ImagenBloc extends Bloc<ImagenEvent, ImagenState> {
  ImagenBloc()
      : super(ImagenLoaded(
          mainImageUrl:
              'https://img.freepik.com/foto-gratis/fondo-degradado-abstracto-borde-azul_53876-104041.jpg',
          themeMode: ThemeMode.light,
        )) {
    on<ToggleImagenThemeEvent>((event, emit) {
      final currentState = state as ImagenLoaded;
      emit(ImagenLoaded(
        mainImageUrl: currentState.themeMode == ThemeMode.dark
            ? 'https://img.freepik.com/foto-gratis/fondo-degradado-abstracto-borde-azul_53876-104041.jpg'
            : 'https://img.freepik.com/foto-gratis/fondo-decorativo-humo_23-2147611841.jpg',
        themeMode: currentState.themeMode == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark,
      ));
    });
  }
}
