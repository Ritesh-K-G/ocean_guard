class QueryModel {
  final String queryID;
  final String queryDescription;
  final List<String> queryImages;
  final bool resolved;

  QueryModel({
    required this.queryID,
    required this.queryDescription,
    required this.queryImages,
    required this.resolved
  });

  factory QueryModel.fromMap(Map<String, dynamic> map) {
    return QueryModel(
        queryID: map['itemID'],
        queryDescription: map['queryDescription'],
        queryImages: map['queryImages'],
        resolved: map['resolved'],
    );
  }
}