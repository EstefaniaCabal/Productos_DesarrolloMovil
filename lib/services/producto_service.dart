import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:productos_app/models/producto_model.dart';

import 'package:http/http.dart' as http;

class ProductoService extends ChangeNotifier {
  final String _baseUrl = 'productos-b7b91-default-rtdb.firebaseio.com';

  final List <Producto> productos = [];

  bool isLoading = true;
  bool isSaving = false;

  Producto? productoSeleccionado;

  //constructor
  ProductoService(){
    this.obtenerProductos();
  }

  //metodo para obtener productos de la base de datos
  Future obtenerProductos() async{
    final url = Uri.https(_baseUrl, 'productos.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productosMap = jsonDecode(resp.body);
   // print(productosMap);

   //recorremos el mapa de la respuesta y vamos agregando
   //productos a la lista
    productosMap.forEach((key, value) {
      final tempProducto = Producto.fromMap(value);
      tempProducto.id = key;
      this.productos.add(tempProducto);
    });

    this.isLoading = false;
    
    
    notifyListeners();

    return this.productos;
  }

  //métdodo para actualizar productos
  Future<String> updateProducto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'productos/${producto.id}.json');
    final resp = await http.put(
      url, 
      body: producto.toJson()
      );

    final decodedData = resp.body;
    print(decodedData);

    final index = 
      this.productos.indexWhere((element) => element.id == producto.id);

    this.productos[index] = producto;

    return producto.id!;
  }

  //método para crear un nuevo producto o actualizar
  Future crearOActualizarProducto(Producto producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
      //producto nuevo
      await this.nuevoProdcuto(producto);
    } else {
      //producto existente
      await this.updateProducto(producto);
    }

    isSaving = false;
    notifyListeners();
  }

  //método para agregar un producto nuevo
  Future<String> nuevoProdcuto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'productos.json');
    final resp = await http.post(
      url, 
      body: producto.toJson()
      );

    final decodedData = json.decode(resp.body);
    // print(decodedData);

    producto.id = decodedData['name'];
    this.productos.add(producto);
    
    return producto.id!;
  }


}