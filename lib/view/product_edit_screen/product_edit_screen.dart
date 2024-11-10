import 'package:flutter/material.dart';
import 'package:token_test/global_widgets/custom_textfield.dart';
import 'package:token_test/global_widgets/refactored_button.dart';
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
            CustomTextField(
              controller: nameController,
              label: "Name",
            ),
            CustomTextField(
              controller: descriptionController,
              label: "Description",
            ),
            CustomTextField(
              controller: priceController,
              label: "Price",
            ),
            CustomTextField(
              controller: stockController,
              label: "Stock",
              isNumber: true, // Stock is a number
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: categoryController,
              label: "Category",
            ),
            SizedBox(height: 20),
            RefactoredButton(
              label: "Save Changes",
              onTap: () {
                // Update product instance with edited details
                product.name = nameController.text;
                product.description = descriptionController.text;
                product.price = priceController.text;
                product.stock = int.parse(stockController.text);
                product.category = categoryController.text;

                // Process updated product (e.g., save changes to database)
                Navigator.pop(context); // Navigate back after editing product
              },
            ),
          ],
        ),
      ),
    );
  }
}
