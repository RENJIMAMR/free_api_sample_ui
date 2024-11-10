import 'package:flutter/material.dart';
import 'package:token_test/model/product_model.dart';

class ProductEditScreen extends StatelessWidget {
  final Product product;

  ProductEditScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: product.name);
    final TextEditingController descriptionController =
        TextEditingController(text: product.description);
    final TextEditingController priceController =
        TextEditingController(text: product.price);
    final TextEditingController stockController =
        TextEditingController(text: product.stock.toString());
    final TextEditingController categoryController =
        TextEditingController(text: product.category);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Product")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name")),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description")),
            TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price")),
            TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number),
            TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: "Category")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update product instance with edited details
                product.name = nameController.text;
                product.description = descriptionController.text;
                product.price = priceController.text;
                product.stock = int.parse(stockController.text);
                product.category = categoryController.text;

                // Process updated product (e.g., save changes to database)
                Navigator.pop(context); // Navigate back after editing product
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
