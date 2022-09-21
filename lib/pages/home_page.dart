import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/todos_model.dart';
import 'package:todo_list_flutter/pages/form_page.dart';
import 'package:todo_list_flutter/providers/todos_provider.dart';
import 'package:todo_list_flutter/utils/app_colors.dart';
import 'package:todo_list_flutter/utils/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodosProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueWhite,
      extendBodyBehindAppBar: true,
      appBar: const _AppBar(),
      body: Stack(
        children: [
          const _TodoList(),
          Positioned(
            top: Dimensions.screenHeight - 85,
            left: Dimensions.screenWidth * 0.8,
            right: Dimensions.screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const FormPage(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: Dimensions.ten * 2.8,
                backgroundColor: AppColors.blue,
                child: Icon(
                  Icons.add,
                  size: Dimensions.ten * 2.7,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoList extends StatelessWidget {
  const _TodoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Dimensions.ten * 13,
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.ten * 2.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Olivia!',
                  style: TextStyle(
                    fontSize: Dimensions.ten * 3,
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyBlack,
                  ),
                ),
                SizedBox(height: Dimensions.ten * 4),
                Text(
                  'CATEGORTIES',
                  style: TextStyle(
                      fontSize: Dimensions.ten * 1.2,
                      color: AppColors.blueGrey),
                ),
                SizedBox(height: Dimensions.ten * 2),
                Row(
                  children: [
                    _Categories(title: 'IMPORTANT', color: AppColors.pink),
                    SizedBox(width: Dimensions.ten * 1.5),
                    _Categories(title: 'NORMAL', color: AppColors.blue),
                  ],
                ),
                SizedBox(height: Dimensions.ten * 4),
                Text(
                  'WHAT\'S FOR TODAY',
                  style: TextStyle(
                      fontSize: Dimensions.ten * 1.2,
                      color: AppColors.blueGrey),
                ),
              ],
            ),
            SizedBox(height: Dimensions.ten * 2),
            Expanded(
              child: SizedBox(
                height: Dimensions.ten * 5,

                // Used consumer for getting values from provider
                child: Consumer(
                  builder: ((context, TodosProvider provider, child) {
                    // ListView for create list
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: provider.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Get values from provider to 'todos' instance
                        TodosModel todos = provider.todos[index];
                        return Container(
                          alignment: Alignment.center,
                          height: Dimensions.ten * 6,
                          margin: EdgeInsets.only(bottom: Dimensions.ten * 0.6),
                          padding: EdgeInsets.only(left: Dimensions.ten),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.ten * 2),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.circle_outlined,
                              color: todos.category == '1'
                                  ? AppColors.pink
                                  : AppColors.blue,
                              size: Dimensions.ten * 2.75,
                            ),
                            title: Text(
                              todos.title,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: Dimensions.ten * 1.8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                provider.remove(index);
                              },
                              icon: Icon(
                                Icons.close_rounded,
                                color: AppColors.blueLight,
                                size: Dimensions.ten * 2,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  final String title;
  final Color color;

  const _Categories({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.ten * 7.8,
      width: Dimensions.ten * 13,
      alignment: Alignment.center,
      padding: EdgeInsets.all(Dimensions.ten),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.ten),
        color: Colors.white,
      ),

      // Used consumer for getting values from provider
      child: Consumer(builder: (context, TodosProvider provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title == 'NORMAL'
                ? Text(
                    '${provider.normal} items',
                    style: TextStyle(
                      color: AppColors.blueGrey,
                      fontSize: Dimensions.ten * 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    '${provider.important} items',
                    style: TextStyle(
                      color: AppColors.blueGrey,
                      fontSize: Dimensions.ten * 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            SizedBox(height: Dimensions.ten),
            Text(
              title,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: Dimensions.ten * 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Dimensions.ten),
            Container(
              height: Dimensions.ten * 0.6,
              width: Dimensions.ten * 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.ten),
                color: color,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: Icon(
        Icons.format_list_bulleted_outlined,
        color: AppColors.greyBlack,
        size: Dimensions.ten * 3,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Dimensions.ten * 1.7),
          child: Container(
            height: Dimensions.ten * 0.5,
            width: Dimensions.ten * 4,
            margin: EdgeInsets.symmetric(vertical: Dimensions.ten * 0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.ten),
              color: AppColors.blue,
            ),
            child: Icon(
              Icons.notifications_rounded,
              color: Colors.white,
              size: Dimensions.ten * 2.5,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.ten * 5.6);
}
