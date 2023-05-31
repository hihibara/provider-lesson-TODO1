// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid(); // uique한 id를 생성하기 위해

class Todo extends Equatable {
  final String id; // 각 TODO 를 구분하기 위한  unique id를 저장하기 위해서
  final String desc; // TODO의 내용을 담기 위해서
  final bool completed; // 해당 TODO가 완료가 됬는지 확인하기 위해서
  Todo({
    String? id, // nullable type
    required this.desc,
    this.completed = false, // todo를 새로 만들때 기본적으로 false로 시작
  }) : id = id ?? uuid.v4(); // id가 외부에서 주어지면 asign 아니면 uui를 사용해 새 id 발

  @override
  List<Object> get props => [id, desc, completed];

  @override
  String toString() => 'Todo(id: $id, desc: $desc, completed: $completed)';
}

enum Filter {
  all,
  active,
  completed,
}
