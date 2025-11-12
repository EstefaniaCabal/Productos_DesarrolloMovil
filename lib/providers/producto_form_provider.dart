
import 'package:flutter/material.dart';
import 'package:productos_app/models/producto_model.dart';

class ProductoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Producto producto;

  ProductoFormProvider(this.producto);

  bool isValidForm() {
    print(producto.nombre);
    print(producto.precio); 
    print(producto.disponible);
    return formKey.currentState?.validate() ?? false;
  }

  updateDisponible(bool value) {
    this.producto.disponible = value;
    notifyListeners();
  }
}