import 'package:flutter/material.dart';
import 'package:token_test/model/product_model.dart';

class ProductAddScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Method to show an error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Input Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            refactoredTextField(nameController, "Product Name"),
            refactoredTextField(descriptionController, "Description"),
            refactoredTextField(priceController, "Price"),
            refactoredTextField(stockController, "Stock", isNumber: true),
            refactoredTextField(categoryController, "Category"),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Validation and creating the product
                if (nameController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    stockController.text.isEmpty ||
                    categoryController.text.isEmpty) {
                  _showErrorDialog(context, 'Please fill in all fields.');
                  return;
                }

                int? stock;
                try {
                  stock = int.parse(stockController.text);
                } catch (e) {
                  _showErrorDialog(context, 'Stock must be a valid integer.');
                  return;
                }

                Product newProduct = Product(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: priceController.text,
                  stock: stock,
                  category: categoryController.text,
                );

                // Return the new product to the previous screen
                Navigator.pop(context, newProduct);
              },
              child: Text("Add Product", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget refactoredTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
        ),
        keyboardType: isNumber
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
      ),
    );
  }
}
