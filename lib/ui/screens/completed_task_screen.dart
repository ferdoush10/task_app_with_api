import 'package:flutter/material.dart';
import 'package:task_mp/ui/widget/profile_summary_card.dart';
import 'package:task_mp/ui/widget/task_item_card.dart';

class CompltedTaskScreen extends StatefulWidget {
  const CompltedTaskScreen({super.key});

  @override
  State<CompltedTaskScreen> createState() => _CompltedTaskScreenState();
}

class _CompltedTaskScreenState extends State<CompltedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const TaskItemCard();
                    }))
          ],
        ),
      ),
    );
  }
}
