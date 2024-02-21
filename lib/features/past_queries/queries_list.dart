import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/sizes.dart';
import 'package:ocean_guard/features/past_queries/query_card.dart';
import 'package:ocean_guard/models/queryModel.dart';

class QueriesDashBoard extends StatefulWidget {
  const QueriesDashBoard({Key? key}) : super(key: key);

  @override
  _QueriesDashBoardState createState() => _QueriesDashBoardState();
}

class _QueriesDashBoardState extends State<QueriesDashBoard> {
  List<QueryModel> sampleQueries = [];

  @override
  void initState() {
    super.initState();
    (()async =>{
      await fetchCardDetails()
    })();
  }
  List<QueryModel> convertToQueryModels(List<dynamic> list) {
    return list.map((item) => QueryModel.fromMap(item)).toList();
  }
  Future<void> fetchCardDetails() async {
    print('0called');
    final dio = Dio();
    final cards = await dio.get('https://backend-kb2pqsadra-et.a.run.app/viewComplaintsUser?user=ishaan');
    print(cards.data);
    sampleQueries = convertToQueryModels(cards.data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sampleQueries.isEmpty
      ? Center(child: CircularProgressIndicator())
      : myBuid();
  }

  Widget myBuid() {
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
                return Column(
                  children: [
                    QueryCard(query: sampleQueries[index]),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}