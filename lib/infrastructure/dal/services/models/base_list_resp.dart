import '../../../../domain/features/user/entities/pagination_entity.dart';

class BaseListResp<T> extends PaginationEntity<T> {
  BaseListResp({
    String? page,
    String? totalDataOnApi,
    required List<T> data,
  }) : super(
          page: int.tryParse(page ?? ''),
          totalDataOnApi: int.tryParse(totalDataOnApi ?? ''),
          data: data,
        );

  BaseListResp.fromJson(Map<String, dynamic> header, dynamic dataResp, Function fromJsonModel)
      : super(
          page: header['x-pagination-page'] != null ? int.tryParse(header['x-pagination-page'][0] ?? '') : null,
          totalDataOnApi:
              header['x-pagination-total'] != null ? int.tryParse(header['x-pagination-total'][0] ?? '') : 0,
          data: dataResp != null
              ? List<T>.from(dataResp.cast<Map<String, dynamic>>().map((itemsJson) => fromJsonModel(itemsJson)))
              : [],
        );
}
