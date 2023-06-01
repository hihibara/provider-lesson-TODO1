import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class TodoSearchState extends Equatable {
  final String searchTerm;
  TodoSearchState({
    required this.searchTerm,
  });

  // Strig을 다루는 데 너무 오바하는 것 처럼 보인다 하지만 2가지 이유가 존재
  //  1. 모든 STATE를 다루는데 일관성을 지키는 것 (협력할때 예측이 가능한 코드를 만들기)
  //  2. type의 충돌을 피하기 위해 (Provider는 type을 기준으로 Widget Tree에서 Object를 찾는다)
  //     type이 같으면 자기에서 더 멀리 떨어진 값을 access할 수 없다
  factory TodoSearchState.initial() {
    // 초기값은 SearchTerm안에 아무것도 없는 상태
    return TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

// State가 바뀔 떄마다 listen하는 Widget에게 값이 바뀐것을 알려줘야 하는 class이다
//   그래서 ChangeNotifier와 mixing을 한다
class TodoSearch with ChangeNotifier {
  TodoSearchState _state = TodoSearchState.initial();
  TodoSearchState get state => _state; // STATE에 access하기 위해서

  void setSearchTerm(String newSearchTerm) {
    // _state안에 newSearchTerm을 argument로 받은 _state를 초기화 한다.
    _state = _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners(); // listener에게 값이 바뀐 것을 알린다.
  }
}
