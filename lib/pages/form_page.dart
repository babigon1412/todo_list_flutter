import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/todos_model.dart';
import 'package:todo_list_flutter/providers/todos_provider.dart';
import 'package:todo_list_flutter/utils/app_colors.dart';
import 'package:todo_list_flutter/utils/dimensions.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form widget
  final titleController =
      TextEditingController(); // For getting value from textField
  bool isImportant = true; // For important checkbox
  bool isNormal = false; // For normal checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: Dimensions.ten * 9.5,
        // Cancel adding list
        leading: TextButton(
          onPressed: () {
            titleController.text = '';
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
                color: AppColors.blue, fontSize: Dimensions.ten * 1.6),
          ),
        ),
        // Confirm adding list
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.ten),
            child: TextButton(
              onPressed: () {
                var provider =
                    Provider.of<TodosProvider>(context, listen: false);

                if (_formKey.currentState!.validate()) {
                  if (isImportant || isNormal) {
                    // For classification categories and count a members
                    // of categories
                    String isChecked = '';
                    if (isImportant) {
                      isChecked = '1';
                      provider.addImportant();
                    } else {
                      isChecked = '0';
                      provider.addNormal();
                    }

                    var title = titleController.text;

                    var value = TodosModel(title: title, category: isChecked);

                    provider.add(value);

                    titleController.text = '';
                    isImportant = false;
                    isNormal = false;

                    Navigator.pop(context);
                  }
                }
              },
              child: Text('Done',
                  style: TextStyle(
                      color: AppColors.blue, fontSize: Dimensions.ten * 1.6)),
            ),
          ),
        ],
      ),
      body: Container(
        height: Dimensions.screenHeight,
        color: AppColors.blueWhite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.ten * 15,
                  left: Dimensions.ten * 2.5,
                  right: Dimensions.ten * 2.5,
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'What you gonna do?',
                  ),
                  autofocus: true,
                  // Validate values before add to list
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price of product.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: Dimensions.ten * 3),
              CheckboxListTile(
                title: Text(
                  'IMPORTANT',
                  style: TextStyle(
                      color: isImportant ? AppColors.pink : AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.ten * 1.5),
                ),
                value: isImportant,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    isImportant = value!;
                    isNormal = !isImportant;
                  });
                },
                activeColor: AppColors.pink,
                checkColor: Colors.white,
              ),
              CheckboxListTile(
                title: Text(
                  'NORMAL',
                  style: TextStyle(
                      color: isNormal ? AppColors.blue : AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.ten * 1.5),
                ),
                value: isNormal,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    isNormal = value!;
                    isImportant = !isNormal;
                  });
                },
                activeColor: AppColors.blue,
                checkColor: Colors.white,
              ),
              SizedBox(height: Dimensions.ten * 5),
            ],
          ),
        ),
      ),
    );
  }
}
