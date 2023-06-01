import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  TodoFilterState({
    required this.filter,
  });

  // factory structure를 만들면 개발하고 시간이 지나도 inital()이 무엇인지 쉽게 알 수 있다.
  factory TodoFilterState.initial() {
    // todo.model.dart에 있는 값을 return한다. // active, completed를 구별하지 않고 전부 보여준다
    return TodoFilterState(filter: Filter.all);
  }

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'TodoFilterState(filter: $filter)';
}

// state가 바뀔때마다 listen하는 widget에게 값이 변경되었다라는 것을 알려줄 것이다
// extend를 사용해도 가능 하지만 이번에는 with으로 mixing
class TodoFilter with ChangeNotifier {
  TodoFilterState _state = TodoFilterState.initial(); // TodoFilter에서 관리할 state

  TodoFilterState get state => _state; // state safe 가드를 만든다

  void changeFilter(Filter newFilter) {
// 새로운 STATE를 만들때 coptwith을 사용한다. 기존 값을 mutation 하지 않고 새로운 값을 만든다
// copywith 함수는 클래스가 여러 propertyf를 가질 때 특히 유용하게 사용가능 변한 값만 argument로 넘겨준다.
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}
