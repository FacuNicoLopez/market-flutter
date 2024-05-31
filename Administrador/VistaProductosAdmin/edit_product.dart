import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

void showEditDialog(BuildContext context, Articulo articulo) {
  final precioController =
      TextEditingController(text: articulo.precio.toString());
  final stockController =
      TextEditingController(text: articulo.stock.toString());
  String? selectedNombreArticulo = articulo.nombreArticulo;
  String? selectedTalleArticulo = articulo.talle;
  String? selectedImageUrl = articulo.imagen;

  final List<String> tallesArticulos = ['S', 'M', 'L', 'XL'];

  final List<String> nombresArticulos = [
    'Remera',
    'Pantalón',
    'Short',
    'Buzo',
    'Campera',
    'Zapato',
    'Camisa',
    'Sueter'
  ];

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        value: selectedNombreArticulo,
                        isExpanded: true,
                        items: nombresArticulos.map((String nombre) {
                          return DropdownMenuItem<String>(
                            value: nombre,
                            child: Text(nombre),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedNombreArticulo = newValue;
                          });
                        },
                        hint: const Text("Seleccione un tipo de producto"),
                      ),
                      DropdownButton<String>(
                        value: selectedImageUrl,
                        isExpanded: true,
                        items: imagenPorProducto[selectedNombreArticulo]
                            ?.map((imagen) {
                          return DropdownMenuItem<String>(
                            value: imagen['url'],
                            child: Row(
                              children: [
                                Image.network(
                                  imagen['url']!,
                                  width: 50,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10),
                                Text(imagen['nombre']!),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedImageUrl = newValue;
                          });
                        },
                        hint: const Text('Seleccione una imagen'),
                      ),
                      DropdownButton<String>(
                        value: selectedTalleArticulo,
                        isExpanded: true,
                        items: tallesArticulos.map((String talle) {
                          return DropdownMenuItem<String>(
                            value: talle,
                            child: Text(talle),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTalleArticulo = newValue;
                          });
                        },
                        hint: const Text("Seleccione el talle"),
                      ),
                      TextFormField(
                        controller: precioController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Precio'),
                      ),
                      TextFormField(
                        controller: stockController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Stock'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Guardar Cambios',
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              if (selectedNombreArticulo == null ||
                                  selectedTalleArticulo == null ||
                                  selectedImageUrl == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Todos los campos deben ser completados."),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              final editedArticulo = Articulo(
                                id: articulo.id,
                                nombreArticulo: selectedNombreArticulo!,
                                talle: selectedTalleArticulo!,
                                precio: double.parse(precioController.text),
                                stock: int.parse(stockController.text),
                                imagen: selectedImageUrl,
                              );
                              BlocProvider.of<ArticuloBloc>(context)
                                  .add(EditArticulo(editedArticulo));
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
