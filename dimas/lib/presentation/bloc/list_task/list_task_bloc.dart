import 'package:dimas/data/models/task.dart';
import 'package:dimas/data/source/task_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_task_event.dart';
part 'list_task_state.dart';

class ListTaskBloc extends Bloc<ListTaskEvent, ListTaskState> {
  ListTaskBloc() : super(ListTaskInitial()) {
    on<OnFetchListTask>((event, emit) async {
      emit(ListTaskLoading());
      List<Task>? result = await TaskSource.whereUserAndStatus(
        event.employeeId,
        event.status,
      );
      if (result == null) {
        emit(ListTaskFailed('Something wrong'));
      } else {
        emit(ListTaskLoaded(result));
      }
    });
  }
}
