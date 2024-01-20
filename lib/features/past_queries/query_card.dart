import 'package:flutter/material.dart';
import 'package:ocean_guard/models/queryModel.dart';

class QueryCard extends StatefulWidget {
  final QueryModel query;

  const QueryCard({Key? key, required this.query}) : super(key: key);

  @override
  _QueryCardState createState() => _QueryCardState();
}

class _QueryCardState extends State<QueryCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Query ID: ${widget.query.queryID}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Image.asset(
                widget.query.queryImages[0],
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                children: [
                  const TextSpan(
                    text: 'Query Description: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: widget.query.queryDescription,
                  )
                ]
              )
            ),
            widget.query.resolved
                ? const Text(
              'Status: Resolved',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            )
                : const Text(
              'Status: Not Resolved',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          ]
        )
      )
    );
  }
}
