import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/sizes.dart';
import 'package:ocean_guard/features/query_description/query.dart';

class todoList extends StatefulWidget {
  @override
  _todoListState createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  List<Map<String, String>> userData = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchCardDetails() async {
    final dio = Dio();
    // late cards = await dio.get();
  }

  @override
  Widget build(BuildContext context) {
    return userData.isEmpty
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
            'Unresolved Queries',
            style: TextStyle(
                fontFamily: 'Hind',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: AppSizes.xl),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  final user = userData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const query(
                              itemID: '',
                            )),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Ink.image(
                                image: const NetworkImage(
                                  'https://i.natgeofe.com/n/88cdf805-08d0-4ce6-8195-230cc46bc1b1/46.jpg',
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
                                    '${user['place']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 24
                                    ),
                                  )
                              )
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
                                      text: '${user['description']}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
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
                                      text: 'Unresolved',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}