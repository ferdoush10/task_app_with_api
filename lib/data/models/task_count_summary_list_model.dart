import 'package:task_mp/data/models/task_count.dart';

class TaskSumaryListCountModel {
  String? status;
  List<TaskCount>? taskCountList;

  TaskSumaryListCountModel({this.status, this.taskCountList});

  TaskSumaryListCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <TaskCount>[];
      json['data'].forEach((v) {
        taskCountList!.add(TaskCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskCountList != null) {
      data['data'] = taskCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
