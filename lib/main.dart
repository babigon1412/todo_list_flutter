import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/pages/home_page.dart';
import 'package:todo_list_flutter/providers/todos_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = const MaterialColor(
      0xFFff3de6,
      <int, Color>{
        50: Color(0xFFff3de6),
        100: Color(0xFFff3de6),
        200: Color(0xFFff3de6),
        300: Color(0xFFff3de6),
        400: Color(0xFFff3de6),
        500: Color(0xFFff3de6),
        600: Color(0xFFff3de6),
        700: Color(0xFFff3de6),
        800: Color(0xFFff3de6),
        900: Color(0xFFff3de6),
      },
    );
    return MultiProvider(
      // Set provider for the app
      providers: [ChangeNotifierProvider(create: (context) => TodosProvider())],
      child: MaterialApp(
        title: 'Todo list',
        theme: ThemeData(
          primarySwatch: mycolor,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
