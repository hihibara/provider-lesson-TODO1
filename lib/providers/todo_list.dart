import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      // 자기 자신을 불러서 초기화 한다.
      Todo(id: '1', desc: 'Clean the room'),
      Todo(id: '2', desc: 'Wash the dish'),
      Todo(id: '3', desc: 'Do homework'),
      // complete argument는 주지 않았기 떄문에 기본값 false가 들어간다
    ]);
  }

  @override
  List<Object> get props => [todos];

  @override
  bool get stringify => true;

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

// listen하는 Widget에게 값이 바뀐것을 알려주는 class
class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state; // 외부에서 state를 access할 수 있도록

  // todo_filter, todo_search와 다르게 다양한 함수를 만든다

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc); // desc를 받은 새로운 doto item을 만듭니다.
    //spread operator를 이용해서 배열을 복사래 newTodos 변수를 만든다.
    final newTodos = [..._state.todos, newTodo]; //

    _state = _state.copyWith(todos: newTodos); // _state 최신화
    print(" TodoList => $_state");
    notifyListeners();
  }

// desc 내용 변경
  void editTodo(String id, String todoDesc) {
    // map을 사용해서 todo items을 모두 확인하고 if문 조건을 만족하는지 비교한다. (비효율적)
    final newTodos = _state.todos.map((Todo todo) {
      print("editTodo");

      print("editTodo => $todo");
      if (todo.id == id) {
        // id가 같다라는 것은 기존에 있는 todo에서 desc만 변경
        return Todo(
          id: id,
          desc: todoDesc,
          completed: todo.completed,
        );
      }
      // 앞에 if문 동작하지 않았다면 id가 다르다는 것이니. 새로운 todo 추가
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

// complete 상태변경
  void toggleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos); // _state 최신화
    notifyListeners();
  }

// 삭제할 todo를 argumnet로 받아서 해당 item을 filter out 합니다.
  void removeTodo(Todo todo) {
    // argument todo만 삭제하고 나머지는 newTodos 안에 다시 할당한다
    final newTodos = _state.todos.where((Todo t) => t.id != todo.id).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
