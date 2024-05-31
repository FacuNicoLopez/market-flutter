import 'package:flutter_csharp3/Producto/product_model.dart';

abstract class ArticuloState {}

class ArticulosLoading extends ArticuloState {}

class ArticulosLoaded extends ArticuloState {
  final List<Articulo> articulos;
  ArticulosLoaded(this.articulos);
}

class ArticulosError extends ArticuloState {
  final String message;
  ArticulosError(this.message);
}

class ArticuloDeleted extends ArticuloState {}

class ArticuloEdited extends ArticuloState {}

class ArticuloLoaded extends ArticuloState {
  final Articulo articuloDetalle;
  ArticuloLoaded(this.articuloDetalle);
}

class ArticuloCargado extends ArticuloState {
  final List<Articulo> articulos;

  ArticuloCargado({required this.articulos});
}
