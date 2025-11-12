
import "package:flutter/material.dart";
import 'package:productos_app/models/producto_model.dart';

class ProductoCard extends StatelessWidget {

  final Producto producto;

  const ProductoCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal:20),
    child: Container( 
        margin:EdgeInsets.only(top:30, bottom:10),
        width: double.infinity,
        height: 400,
      //  color: Colors.red,
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0,7),
            blurRadius: 10,
          )
        ]
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
            _BackgroundImage(imagenUrl: producto.imagen),
            _DetallesProducto(
              nombre: producto.nombre,
              id: producto.id!,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _Precio(
                precio: producto.precio,
              ),
            ),
            if(!producto.disponible)
            Positioned(
              top: 0,
              left: 0,
              child: _NoDisponible(),
            ),
        ],
      ),
    ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {

  final String? imagenUrl;

  const _BackgroundImage({this.imagenUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
          width: double.infinity,
          height:400,
          child: imagenUrl ==null
          ? Image (
              image: AssetImage('assets/no-image.png'),
               fit: BoxFit.cover,
          )
          :FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'), 
            image: NetworkImage(imagenUrl!),
            fit: BoxFit.cover,
            ),
      ),
      );
  }

}

class _DetallesProducto extends StatelessWidget {

  final String nombre;
  final String id;

  const _DetallesProducto({super.key,
   required this.nombre, required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10
        ),
        width: double.infinity,
        height: 70,
        //color: Colors.indigo,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: TextStyle(
                fontSize: 20, 
                color: Colors.white,
                fontWeight: FontWeight.bold
                ),
                maxLines: 1,
                overflow:TextOverflow.ellipsis,
            ),
            Text(
              id,
              style: TextStyle(
                fontSize: 15, 
                color: Colors.white,
                ),
            ),
          ],
        )
      ),
    );
  }
}

class _Precio extends StatelessWidget {

  final double precio;
 
 
 const _Precio({super.key, required this.precio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        )
      ),
      child:  FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$precio',
            style:TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

class _NoDisponible extends StatelessWidget {
  //const _NoDisponible({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style:TextStyle(
              color: Colors.white,
              fontSize: 20,
              ),
          ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          )
      ),
      width: 100,
      height: 70,
      );
  }
}