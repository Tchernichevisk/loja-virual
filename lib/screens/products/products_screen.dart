import 'package:flutter/material.dart';
import 'package:loja_virtual/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/products/components/search_dialog.dart';
import 'package:provider/provider.dart';

import 'components/product_list_tile.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showDialog(context: context,
                  builder:(_) => SearchDialog() );

            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: productManager.allProducts.length,
              itemBuilder: (_, index){
                return ProductListTile(productManager.allProducts[index]);
              }
          );
        },
      ),
    );
  }
}