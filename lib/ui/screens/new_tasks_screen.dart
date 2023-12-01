// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:task_mp/ui/screens/add_new_task_screen.dart';
import 'package:task_mp/ui/widget/profile_summary_card.dart';
import 'package:task_mp/ui/widget/sumarry_card.dart';
import 'package:task_mp/ui/widget/task_item_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({
    super.key,
  });

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    SummeryCard(title: "New", count: '60'),
                    SummeryCard(title: "InProgress", count: '90'),
                    SummeryCard(title: "Completed", count: '40'),
                    SummeryCard(title: "Cancel", count: '00'),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const TaskItemCard();
                    }))
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
