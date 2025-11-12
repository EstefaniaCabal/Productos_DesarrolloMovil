import 'package:flutter/material.dart';
import 'package:productos_app/models/producto_model.dart';
import 'package:productos_app/screens/loading_screen.dart';
import 'package:productos_app/services/producto_service.dart';
import 'package:productos_app/widgets/producto_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productoService = Provider.of<ProductoService>(context);

    if (productoService.isLoading) return LoadingScreen();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productoService.productos.length,
        itemBuilder: (context, index) => 
        //Text('Item $index') ,
        GestureDetector(
          child: ProductoCard(
            producto: productoService.productos[index],
          ),
          onTap: () { 
            productoService.productoSeleccionado = 
              productoService.productos[index].copy();
            Navigator.pushNamed(context, 'producto');
          
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productoService.productoSeleccionado = new
            Producto( disponible: false, nombre: '', precio: 0 );
          Navigator.pushNamed(context, 'producto');
        },
      ),
    );
  }
}