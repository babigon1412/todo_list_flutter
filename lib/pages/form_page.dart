import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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
  bool isImportant = false; // For important checkbox
  String pickerDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  void _DayPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
    ).then((value) {
      setState(() {
        DateTime date = value!;
        pickerDate = DateFormat('dd-MM-yyyy').format(date);
      });
    });
  }

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
                color: AppColors.blueGrey, fontSize: Dimensions.ten * 1.6),
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

                  var value = TodosModel(
                    title: title,
                    category: isChecked,
                    date: pickerDate,
                  );

                  provider.add(value);

                  titleController.text = '';

                  Navigator.pop(context);
                }
              },
              child: Text(
                'Done',
                style: TextStyle(
                  color: isImportant ? AppColors.pink : AppColors.blue,
                  fontSize: Dimensions.ten * 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Dimensions.screenHeight,
          color: AppColors.blueWhite,
          padding: EdgeInsets.only(
            top: Dimensions.ten * 15,
            left: Dimensions.ten * 2.5,
            right: Dimensions.ten * 2.5,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: titleController,
                  style: TextStyle(fontSize: Dimensions.ten * 2),
                  decoration: InputDecoration(
                    hintText: 'What you gonna do?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.ten),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  cursorHeight: Dimensions.ten * 3,

                  // Validate values before add to list
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter what you gonna do.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Dimensions.ten * 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: _DayPicker,
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: BorderSide(width: 2, color: AppColors.blueGrey),
                      ),
                      child: Row(
                        children: [
                          pickerDate ==
                                  DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now())
                                      .toString()
                              ? Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: Dimensions.ten * 1.8,
                                    color: AppColors.blueGrey,
                                  ),
                                )
                              : Text(
                                  pickerDate,
                                  style: TextStyle(
                                    fontSize: Dimensions.ten * 1.8,
                                    color: AppColors.blueGrey,
                                  ),
                                ),
                          SizedBox(width: Dimensions.ten * 1.0),
                          IconButton(
                            onPressed: _DayPicker,
                            icon: SvgPicture.asset(
                              'assets/icons/calendar_3.svg',
                              height: Dimensions.ten * 4,
                              width: Dimensions.ten * 4,
                              color: AppColors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isImportant = !isImportant;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(
                            width: 2, color: Colors.transparent),
                      ),
                      child: isImportant
                          ? Icon(
                              Icons.star_rounded,
                              size: Dimensions.ten * 4,
                            )
                          : Icon(
                              Icons.star_border_rounded,
                              size: Dimensions.ten * 4,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
