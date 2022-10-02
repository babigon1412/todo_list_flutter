import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _TodoList extends StatefulWidget {
  const _TodoList({
    Key? key,
  }) : super(key: key);

  @override
  State<_TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<_TodoList> {
  int isImportant = 0;

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
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isImportant = 1;
                          });
                        },
                        child: _Categories(
                            title: 'IMPORTANT', color: AppColors.pink)),
                    SizedBox(width: Dimensions.ten),
                    GestureDetector(
                        onTap: (() {
                          setState(() {
                            isImportant = 2;
                          });
                        }),
                        child: _Categories(
                            title: 'NORMAL', color: AppColors.blue)),
                    SizedBox(width: Dimensions.ten),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isImportant = 0;
                          });
                        },
                        child: Container(
                          height: Dimensions.ten * 7.8,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.ten),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.ten),
                            color: Colors.white,
                          ),
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: Dimensions.ten * 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.ten * 4),
                Text(
                  'DON\'T MISS IT',
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
                        if (isImportant == 0) {
                          // Show all of list
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: Dimensions.ten * 6,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.ten * 0.6),
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
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                              ),
                            ],
                          );
                        } else if (isImportant == 1) {
                          // Show important list
                          return todos.category == '1'
                              ? Container(
                                  alignment: Alignment.center,
                                  height: Dimensions.ten * 6,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.ten * 0.6),
                                  padding:
                                      EdgeInsets.only(left: Dimensions.ten),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.ten * 2),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.circle_outlined,
                                      color: AppColors.pink,
                                      size: Dimensions.ten * 2.75,
                                    ),
                                    title: Text(
                                      todos.title,
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: Dimensions.ten * 1.8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                )
                              : const SizedBox.shrink();
                        } else if (isImportant == 2) {
                          // Show normal list
                          return todos.category == '0'
                              ? Container(
                                  alignment: Alignment.center,
                                  height: Dimensions.ten * 6,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.ten * 0.6),
                                  padding:
                                      EdgeInsets.only(left: Dimensions.ten),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.ten * 2),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.circle_outlined,
                                      color: AppColors.blue,
                                      size: Dimensions.ten * 2.75,
                                    ),
                                    title: Text(
                                      todos.title,
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: Dimensions.ten * 1.8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                )
                              : const SizedBox.shrink();
                        } else {
                          return const SizedBox.shrink();
                        }
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
      leading: Padding(
        padding: EdgeInsets.only(left: Dimensions.ten),
        child: Container(
          width: Dimensions.ten * 3.2,
          margin: EdgeInsets.symmetric(vertical: Dimensions.ten * 0.8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.ten),
            color: Colors.transparent,
          ),
          child: Icon(
            Icons.menu_rounded,
            color: AppColors.blueGrey,
            size: Dimensions.ten * 3,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Dimensions.ten * 1.5),
          child: Container(
            width: Dimensions.ten * 3.2,
            margin: EdgeInsets.symmetric(vertical: Dimensions.ten * 0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.ten),
              color: Colors.transparent,
            ),
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              color: AppColors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.ten * 5.6);
}
