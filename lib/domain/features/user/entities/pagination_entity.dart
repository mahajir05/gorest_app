class PaginationEntity<T> {
  final int? page;
  final int? totalDataOnApi;
  final List<T> data;

  PaginationEntity({this.page, this.totalDataOnApi, required this.data});

  bool get isMaxData => data.length == totalDataOnApi;
}
