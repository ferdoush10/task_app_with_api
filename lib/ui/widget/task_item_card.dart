// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:task_mp/data/models/task.dart';
import 'package:task_mp/data/network_caller/network_caller.dart';
import 'package:task_mp/data/utility/urls.dart';

enum TaskStatus { New, Progress, Completed, Cancelled }

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    Key? key,
    required this.task,
    required this.onStatuschange,
    required this.showProgress,
  }) : super(key: key);
  final Task task;
  final VoidCallback onStatuschange;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  ///UpdateTask status method
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    setState(() {});
    if (response.isSuccess) {
      widget.onStatuschange();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(widget.task.description ?? ''),
            Text('Date: ${widget.task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(Icons.delete_forever_outlined)),
                    IconButton(
                        onPressed: () {
                          showUpdateStatusModal();
                        },
                        icon: const Icon(Icons.edit)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Update Status',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Calcel')),
                  // TextButton(onPressed: () {}, child: const Text('Update'))
                ],
              ),
            ],
          );
        });
  }
}
