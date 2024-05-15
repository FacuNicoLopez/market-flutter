import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_csharp3/Producto/product_event.dart';
import 'package:flutter_csharp3/Producto/product_model.dart';
import 'package:flutter_csharp3/Producto/product_state.dart';
import 'package:flutter_csharp3/config.dart';
import 'package:http/http.dart' as http;

class ArticuloBloc extends Bloc<ArticuloEvent, ArticuloState> {
  final url4 = direccionUrl;

  ArticuloBloc() : super(ArticulosLoading()) {
    on<LoadArticulos>(_onLoadArticulos);
    on<DeleteArticulo>(_onDeleteArticulo);
    on<EditArticulo>(_onEditArticulo);
    on<AddArticulo>(_onAddArticulo);
    on<LoadArticuloDetalle>(_onLoadArticuloDetalle);
    on<UpdateStock>(_onUpdateStock);
    on<DeleteStock>(_onDeleteStock);
  }

  void _onLoadArticulos(
      LoadArticulos event, Emitter<ArticuloState> emit) async {
    emit(ArticulosLoading());
    try {
      final response = await http.get(Uri.parse('$url4/articulo'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          final articulos =
              data.map((json) => Articulo.fromJson(json)).toList();
          emit(ArticulosLoaded(articulos));
        } else {
          emit(ArticulosError('Formato de respuesta incorrecto'));
        }
      }
    } catch (e) {
      emit(ArticulosError('Error al cargar articulos: ${e.toString()}'));
    }
  }

  void _onDeleteArticulo(
      DeleteArticulo event, Emitter<ArticuloState> emit) async {
    try {
      final response = await http.delete(
          Uri.parse('$url4/articulo/${event.articuloId}/delete'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (response.statusCode == 204) {
        emit(ArticuloDeleted());
        add(LoadArticulos());
      } else if (response.statusCode == 400) {
        emit(ArticulosError(
            'El artículo no puede ser eliminado porque está en uno o más carritos.'));
        add(LoadArticulos());
      } else {
        emit(ArticulosError('Error al eliminar artículo'));
      }
    } catch (e) {
      emit(ArticulosError('Error al eliminar articulo: ${e.toString()}'));
    }
  }

  void _onEditArticulo(EditArticulo event, Emitter<ArticuloState> emit) async {
    try {
      final response = await http.put(
        Uri.parse('$url4/articulo/${event.articulo.id}/edit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(event.articulo.toJson()),
      );
      if (response.statusCode == 204) {
        emit(ArticuloEdited());
        add(LoadArticulos());
      } else {
        emit(ArticulosError('Error al editar articulo'));
      }
    } catch (e) {
      emit(ArticulosError('Error al editar articulo: ${e.toString()}'));
    }
  }

  void _onAddArticulo(AddArticulo event, Emitter<ArticuloState> emit) async {
    final jsonArticulo = jsonEncode(event.articulo.toJson());

    try {
      final response = await http.post(
        Uri.parse('$url4/articulo/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonArticulo,
      );

      if (response.statusCode == 201) {
        final nuevoArticulo = Articulo.fromJson(jsonDecode(response.body));
        if (state is ArticulosLoaded) {
          final currentState = state as ArticulosLoaded;
          emit(ArticulosLoaded([...currentState.articulos, nuevoArticulo]));
        }
      } else {
        emit(ArticulosError('Error al agregar articulo: ${response.body}'));
      }
    } catch (e) {
      emit(ArticulosError('Error al agregar articulo: ${e.toString()}'));
    }
  }

  void _onLoadArticuloDetalle(
      LoadArticuloDetalle event, Emitter<ArticuloState> emit) async {
    emit(ArticulosLoading());
    try {
      final response = await http
          .get(Uri.parse('$url4/articulo/${event.articuloDetalleId}'));
      if (response.statusCode == 200) {
        final articulo = Articulo.fromJson(json.decode(response.body));
        emit(ArticuloLoaded(articulo));
      } else {
        emit(ArticulosError(
            'Error al cargar el artículo: ${response.statusCode}'));
      }
    } catch (e) {
      emit(
          ArticulosError('Error al conectar con el servidor: ${e.toString()}'));
    }
  }

  void _onUpdateStock(UpdateStock event, Emitter<ArticuloState> emit) {
    if (state is ArticulosLoaded) {
      List<Articulo> updatedArticulos =
          (state as ArticulosLoaded).articulos.map((articulo) {
        if (articulo.id == event.articuloId) {
          return articulo.copyWith(stock: event.newStock);
        }
        return articulo;
      }).toList();

      emit(ArticulosLoaded(updatedArticulos));
    }
  }

  void _onDeleteStock(DeleteStock event, Emitter<ArticuloState> emit) async {
    final currentState = state;
    if (currentState is ArticulosLoaded) {
      final index = currentState.articulos
          .indexWhere((articulo) => articulo.id == event.articuloDeleteId);
      if (index == -1) {
        emit(ArticulosError("Articulo no encontrado"));
        return;
      }
      try {
        final response = await http.delete(
          Uri.parse('$url4/articulo/${event.articuloDeleteId}/delete/stock'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTP=8',
          },
          body: jsonEncode({'newStock': event.updateStock}),
        );

        if (response.statusCode == 200) {
          final newArticulos = List<Articulo>.from(currentState.articulos);
          newArticulos[index] =
              newArticulos[index].copyWith(stock: event.updateStock);
          emit(ArticulosLoaded(newArticulos));
        }
      } catch (e) {
        emit(ArticulosError('Error al editar stock ${e.toString()}'));
      }
    }
  }
}
