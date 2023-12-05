import 'package:flutter/material.dart';
import 'package:task_mp/data/models/task_list_model.dart';
import 'package:task_mp/data/network_caller/network_caller.dart';
import 'package:task_mp/data/network_caller/network_response.dart';
import 'package:task_mp/data/utility/urls.dart';
import 'package:task_mp/ui/widget/profile_summary_card.dart';
import 'package:task_mp/ui/widget/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool getProgressTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTaskList() async {
    getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
                child: Visibility(
              visible: getProgressTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: getProgressTaskList,
                child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        onStatuschange: () {
                          getProgressTaskList();
                        },
                        showProgress: (inProgress) {
                          getProgressTaskInProgress = inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    }),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
