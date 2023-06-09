import 'package:elredtodo/app/core/themes/theme.dart';
import 'package:elredtodo/app/core/utils/router.dart';
import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:elredtodo/app/data/services/authservice.dart';
import 'package:elredtodo/app/modules/home/helper_widget/home_appbar.dart';
import 'package:elredtodo/app/modules/home/helper_widget/todo_listtile.dart';
import 'package:elredtodo/app/modules/home/homeprovider.dart';
import 'package:elredtodo/app/modules/login/loginpage.dart';
import 'package:elredtodo/app/modules/todo/todo_cudpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    homeProvider.fetchTodoData();
    return Scaffold(
      backgroundColor: lightColor,
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (await auth.currentUser != null) {
            context.push(const TodoPage());
          } else {
            loginLogOutDialog(context);
          }
        },
        child: Material(
          elevation: 10.0,
          color: secondaryColor,
          shadowColor: secondaryColor,
          shape: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.add, size: 28.0, color: Colors.white),
          ),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          if (value.todoList != null && (value.todoList?.isNotEmpty ?? false)) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: HomeAppBarSliver(
                    expandedHeight: 230,
                    appBarHeight: kToolbarHeight,
                    safeAreaHeight: MediaQuery.of(context).padding.top,
                    businessCount: value.getBusinessCount,
                    personalCount: value.getPersonalCount,
                    donePercentage: value.getDonePercentage,
                  ),
                  pinned: true,
                ),
                if ((value.getInboxTodo?.length ?? 0) != 0)
                  todoSectionTitle("INBOX"),
                if ((value.getInboxTodo?.length ?? 0) != 0)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => todoListTile(
                        value.getInboxTodo?[index] ?? Todo(),
                        onIconTap: () => value.markDone(
                            value.getInboxTodo?[index].id ?? '', true),
                        onTileTap: () => context
                            .push(TodoPage(todo: value.getInboxTodo?[index])),
                      ),
                      childCount: value.getInboxTodo?.length ?? 0,
                    ),
                  ),
                if ((value.getCompleteTodo?.length ?? 0) != 0)
                  todoSectionTitle("COMPLETED",
                      totalCount: value.getCompleteTodo?.length ?? 0),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => todoListTile(
                      value.getCompleteTodo?[index] ?? Todo(),
                      completed: true,
                      onIconTap: () => value.markDone(
                          value.getCompleteTodo?[index].id ?? '', false),
                      onTileTap: () => context
                          .push(TodoPage(todo: value.getCompleteTodo?[index])),
                    ),
                    childCount: value.getCompleteTodo?.length ?? 0,
                  ),
                )
              ],
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: HomeAppBarSliver(
                    expandedHeight: 230,
                    appBarHeight: kToolbarHeight,
                    safeAreaHeight: MediaQuery.of(context).padding.top,
                  ),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        230 -
                        MediaQuery.of(context).padding.top,
                    child: Center(
                      child: value.isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Nothing to show \n Add your things"),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
