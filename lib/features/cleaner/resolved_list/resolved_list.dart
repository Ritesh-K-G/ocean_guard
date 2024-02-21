import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/sizes.dart';
import 'package:ocean_guard/features/query_description/query.dart';
import 'package:ocean_guard/models/queryModel.dart';

class ResolvedList extends StatefulWidget {
  const ResolvedList({super.key});

  @override
  _ResolvedListState createState() => _ResolvedListState();
}

class _ResolvedListState extends State<ResolvedList> {
  List<QueryModel> cardsData = [];
  String? userID = "";
  bool serverCalled = false;

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
    final dio = Dio();
    // userID = FirebaseAuth.instance.currentUser?.uid;
    userID = 'nKLVSheOXfTsJsXssA3gzh3SEX92';
    var res = await dio.get('https://backend-kb2pqsadra-et.a.run.app/viewComplaintsResolved?user=$userID');
    print(res);
    cardsData = convertToQueryModels(res.data);
    print(cardsData);
    setState(() {
      serverCalled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return serverCalled == false
        ? Center(child: CircularProgressIndicator())
        : myBuild();
  }

  Widget myBuild() {
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
            'Resolved Queries',
            style: TextStyle(
                fontFamily: 'Hind',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: AppSizes.xl),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: cardsData.length,
                itemBuilder: (context, index) {
                  final user = cardsData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => query(
                              cardData: user,
                            )),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Ink.image(
                                image: NetworkImage(
                                  user.resolvedImages[0],
                                ),
                                height: 240,
                                fit: BoxFit.cover,
                                child: InkWell(
                                  onTap: () {},
                                ),
                              ),
                              Positioned(
                                  bottom: 16,
                                  right: 16,
                                  left: 16,
                                  child: Text(
                                    '${user.place}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 24),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Description: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${user.description}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(height: 5),
                          Padding(
                              padding: const EdgeInsets.all(16).copyWith(bottom: 8),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Status: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Resolved',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
