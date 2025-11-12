
import 'package:flutter/material.dart';

class ProductoImagen extends StatelessWidget {

  final String? imagenUrl;

  const ProductoImagen({super.key, this.imagenUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:10, right: 10, top:10),
      child: Container(
        height:450,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]
        ),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: this.imagenUrl== null
            ? Image(
              image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover,
            )
            : FadeInImage(
              image: NetworkImage(this.imagenUrl!),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fit:BoxFit.cover,
              ),
            ),
        ),
        ),
      );
  }
}