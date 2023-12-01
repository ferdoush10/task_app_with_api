import 'package:flutter/material.dart';

class SummeryCard extends StatelessWidget {
  const SummeryCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String count, title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            Text(
              count,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
