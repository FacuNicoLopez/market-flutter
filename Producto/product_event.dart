import 'package:flutter_csharp3/Producto/product_model.dart';

abstract class ArticuloEvent {}

class LoadArticulos extends ArticuloEvent {}

class DeleteArticulo extends ArticuloEvent {
  final int articuloId;
  DeleteArticulo(this.articuloId);
}

class EditArticulo extends ArticuloEvent {
  final Articulo articulo;
  EditArticulo(this.articulo);
}

class AddArticulo extends ArticuloEvent {
  final Articulo articulo;
  AddArticulo(this.articulo);
}

class LoadArticuloDetalle extends ArticuloEvent {
  final int articuloDetalleId;

  LoadArticuloDetalle(this.articuloDetalleId);
}

class UpdateStock extends ArticuloEvent {
  final int articuloId;
  final int newStock;

  UpdateStock({required this.articuloId, required this.newStock});
}

class DeleteStock extends ArticuloEvent {
  final int articuloDeleteId;
  final int updateStock;

  DeleteStock({required this.articuloDeleteId, required this.updateStock});
}
