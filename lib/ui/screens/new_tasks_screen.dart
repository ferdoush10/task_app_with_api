// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_mp/data/models/task_count.dart';
import 'package:task_mp/data/models/task_count_summary_list_model.dart';
import 'package:task_mp/data/models/task_list_model.dart';
import 'package:task_mp/data/network_caller/network_caller.dart';
import 'package:task_mp/data/network_caller/network_response.dart';
import 'package:task_mp/data/utility/urls.dart';
import 'package:task_mp/ui/screens/add_new_task_screen.dart';
import 'package:task_mp/ui/widget/profile_summary_card.dart';
import 'package:task_mp/ui/widget/sumarry_card.dart';
import 'package:task_mp/ui/widget/task_item_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  //Variable
  bool getNewTaskInProgress = false;
  bool getTaskCountSummaryInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  TaskSumaryListCountModel taskSumaryListCountModel =
      TaskSumaryListCountModel();

  //get New task list method
  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskCountSummaryList() async {
    getTaskCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskSumaryListCountModel =
          TaskSumaryListCountModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
    getTaskCountSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Visibility(
                visible: getTaskCountSummaryInProgress == false,
                replacement: const Center(
                  child: LinearProgressIndicator(),
                ),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          taskSumaryListCountModel.taskCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                        TaskCount taskCount =
                            taskSumaryListCountModel.taskCountList![index];
                        return SummeryCard(
                            title: taskCount.sId ?? '',
                            count: taskCount.sum.toString());
                      }),
                )),
            Expanded(
                child: Visibility(
              visible: getNewTaskInProgress == false &&
                  (taskSumaryListCountModel.taskCountList?.isNotEmpty ?? false),
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      task: taskListModel.taskList![index],
                    );
                  }),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddNewTaskScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
