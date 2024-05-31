import 'package:flutter_csharp3/Administrador/screen_view_admin.dart';

void showAddDialog(BuildContext context) {
  final precioController = TextEditingController();
  final stockController = TextEditingController();
  String? selectedNombreArticulo;
  String? selectedTalleArticulo;
  String? selectedImageUrl;
  List<Map<String, String>>? currentImageOptions;

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
      barrierColor: Colors.black45,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
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
                            currentImageOptions = imagenPorProducto[newValue];
                            selectedImageUrl = null;
                          });
                        },
                        hint: const Text("Seleccione un tipo de producto"),
                      ),
                      if (selectedNombreArticulo != null &&
                          currentImageOptions != null)
                        DropdownButton<String>(
                          value: selectedImageUrl,
                          isExpanded: true,
                          items: currentImageOptions!
                              .map((Map<String, String> imagen) {
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
                                  Text(imagen['nombre']!)
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedImageUrl = newValue;
                            });
                          },
                          hint: const Text('Selecciona una imagen'),
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
                        hint: const Text("Seleccione un talle"),
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
                              'Guardar',
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () {
                              if (selectedNombreArticulo == null ||
                                  selectedTalleArticulo == null ||
                                  precioController.text.isEmpty ||
                                  stockController.text.isEmpty ||
                                  selectedImageUrl == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Porfavor, complete todos los campos'),
                                  backgroundColor: Colors.red,
                                ));
                                return;
                              }
                              try {
                                final nuevoArticulo = Articulo(
                                    nombreArticulo: selectedNombreArticulo!,
                                    talle: selectedTalleArticulo!,
                                    precio: double.parse(stockController.text),
                                    stock: int.parse(stockController.text),
                                    imagen: selectedImageUrl);
                                BlocProvider.of<ArticuloBloc>(context)
                                    .add(AddArticulo(nuevoArticulo));
                                Navigator.of(context).pop();
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Error al guardar: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ));
                              }
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
