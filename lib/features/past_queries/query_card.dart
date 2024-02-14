import 'package:flutter/material.dart';
import 'package:ocean_guard/features/query_description/query.dart';
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
                const Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Text(
                      'Juhu Chapati Beach',
                      style: TextStyle(
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
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Description: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Lorem Ipsum Lorem Ipsum',
                        style: TextStyle(
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
  }
}
