import 'package:flutter/material.dart';
import '../models/degree.dart';

class DegreeListItem extends StatelessWidget {
  final Degree degree;
  
  const DegreeListItem({super.key, required this.degree});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(degree.name),
        subtitle: Text('${degree.duration} years'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (degree.description.isNotEmpty) ...[
                  Text(
                    'Description:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(degree.description),
                  const SizedBox(height: 8),
                ],
                if (degree.requirements.isNotEmpty) ...[
                  Text(
                    'Requirements:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  ...degree.requirements.map((req) => Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(child: Text(req)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 8),
                ],
                if (degree.careerOptions.isNotEmpty) ...[
                  Text(
                    'Career Options:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(degree.careerOptions.join(', ')),
                ],
                if (degree.fee > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Approximate Fee:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text('Rs. ${degree.fee.toStringAsFixed(0)}'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}