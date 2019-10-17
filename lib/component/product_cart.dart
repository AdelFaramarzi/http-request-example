import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:products/model/product.dart';

class ProductCart extends StatelessWidget{
  final Products products;

  ProductCart({@required this.products});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    
    return new Container(
      margin: const EdgeInsets.only(right: 5,left: 5,bottom: 10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new Container(
            height: 200,
            width: screenSize.width,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: products.image,
              placeholder: (context, url) => new Image(
                image: AssetImage("assets/placeholder-img.jpg"),
                fit: BoxFit.cover,
              ),

            ),
          ),
          new Container(
            alignment: Alignment.centerRight,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black45
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 15,left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new Text(products.title, style: TextStyle(color: Colors.white),),
                new RichText(
                  maxLines: 1,
                  text: TextSpan(
                    text: products.body,
                    style: TextStyle(color: Colors.white,
                    fontSize: 13)
                  ),
                )
              ],),
            ),
          )
        ],
      ),
    );
  }

}