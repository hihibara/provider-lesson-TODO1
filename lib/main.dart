import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/todos_page.dart';
import 'providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // 여러개의 provider를 사용할떄 쓴다.
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodoCount>(
            // create: 삭제
            update: (
          BuildContext context,
          TodoList todoList,
          ActiveTodoCount? _, //  activeTodoCount => _로 변경
        ) =>
                ActiveTodoCount(todoList: todoList)
            // activeTodoCount!..update(todoList) => ActiveTodoCount(todoList: todoList)
            ),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
            // create: 삭제
            update: (
          BuildContext context,
          TodoFilter todoFilter,
          TodoSearch todoSearch,
          TodoList todoList,
          FilteredTodos? _, // filteredTodos => _로 변경
        ) => //filteredTodos..update(todoFilter, todoSearch, todoList) => FilteredTodos( todoFilter: todoFilter,todoSearch: todoSearch,todoList: todoList)), 로변경
                FilteredTodos(
                    todoFilter: todoFilter,
                    todoSearch: todoSearch,
                    todoList: todoList)),
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
