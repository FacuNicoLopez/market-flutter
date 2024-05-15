import 'package:flutter/material.dart';

abstract class ImagenState {}

class ImagenInitial extends ImagenState {}

class ImagenLoaded extends ImagenState {
  final String mainImageUrl;
  final ThemeMode themeMode;

  ImagenLoaded({required this.mainImageUrl, required this.themeMode});
}
