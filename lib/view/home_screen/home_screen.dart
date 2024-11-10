import 'package:flutter/material.dart';
import 'package:token_test/model/product_model.dart';
import 'package:token_test/view/product_add_screen/product_adding_screen.dart';
import 'package:token_test/view/product_edit_screen/product_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  // Method to add a new product to the list
  void _addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  // Method to edit an existing product
  void _editProduct(int index, Product updatedProduct) {
    setState(() {
      products[index] = updatedProduct;
    });
  }

  // Method to delete a product from the list
  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: products.isEmpty
          ? Center(
              child:
                  Text("No products added yet", style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            // Navigate to ProductEditScreen and await the updated product
                            final updatedProduct =
                                await Navigator.push<Product>(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductEditScreen(product: product),
                              ),
                            );

                            // If the product was updated, update it in the list
                            if (updatedProduct != null) {
                              _editProduct(index, updatedProduct);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Delete the product from the list
                            _deleteProduct(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to ProductAddScreen and await the result
          final newProduct = await Navigator.push<Product>(
            context,
            MaterialPageRoute(builder: (context) => ProductAddScreen()),
          );

          // If a product was added, add it to the list
          if (newProduct != null) {
            _addProduct(newProduct);
          }
        },
        child: Icon(Icons.add),
        tooltip: "Add Product",
        backgroundColor: Colors.green,
      ),
    );
  }
}
