import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/sizes.dart';
import 'package:ocean_guard/features/past_queries/query_card.dart';
import 'package:ocean_guard/models/queryModel.dart';

class QueriesDashBoard extends StatefulWidget {
  QueriesDashBoard({Key? key}) : super(key: key);

  @override
  _QueriesDashBoardState createState() => _QueriesDashBoardState();
}

class _QueriesDashBoardState extends State<QueriesDashBoard> {
  final List<QueryModel> sampleQueries = [
    QueryModel(
        queryID: '1',
        queryDescription:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. '
            'Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo '
            'reprehenderit optio amet ab temporibus asperiores quasi cupiditate. '
            'Voluptatum ducimus voluptates voluptas?',
        queryImages: ['assets/images/dirty-ocean.jpg'],
        resolved: false
    ),
    QueryModel(
        queryID: '2',
        queryDescription:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. '
            'Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo '
            'reprehenderit optio amet ab temporibus asperiores quasi cupiditate. '
            'Voluptatum ducimus voluptates voluptas?',
        queryImages: ['assets/images/world-map.gif'],
        resolved: false
    ),
    QueryModel(
        queryID: '3',
        queryDescription:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. '
            'Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo '
            'reprehenderit optio amet ab temporibus asperiores quasi cupiditate. '
            'Voluptatum ducimus voluptates voluptas?',
        queryImages: ['assets/images/dirty-ocean.jpg'],
        resolved: true
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Queries Dashboard',
            style: TextStyle(
                fontFamily: 'Hind',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: AppSizes.xxl),
          ),
          const SizedBox(height: 20),
          const Text(
            'Past Queries',
            style: TextStyle(
                fontFamily: 'Hind',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: AppSizes.xl),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: sampleQueries.length,
              itemBuilder: (context, index) {
                return QueryCard(query: sampleQueries[index]);
              },
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}