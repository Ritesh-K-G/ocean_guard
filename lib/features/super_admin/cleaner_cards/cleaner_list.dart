import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final List<Map<String, String>> userData = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'place': 'New York',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'place': 'Los Angeles',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'place': 'Los Angeles',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'place': 'Los Angeles',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'place': 'Los Angeles',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'place': 'Los Angeles',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        final user = userData[index];
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[400]
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${user['name']}',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Email: ${user['email']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Place: ${user['place']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFC62020),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(2.0),
                          child: const Text(
                            'Discard',
                            style: TextStyle(
                                color: Color(0xFFFDFDFD),
                                fontFamily: 'Hind',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF13C39C),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(2.0),
                          child: const Text(
                            'Approve',
                            style: TextStyle(
                              color: Color(0xFFFDFDFD),
                              fontFamily: 'Hind',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}