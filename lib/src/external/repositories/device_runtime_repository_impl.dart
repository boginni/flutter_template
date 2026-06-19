import 'package:error_handler_with_result/error_handler_with_result.dart';

import '../../domain/repositories/device_runtime_repository.dart';
import '../datasources/device_runtime_datasource.dart';

class DeviceRuntimeRepositoryImpl implements DeviceRuntimeRepository {
  final DeviceRuntimeDatasource datasource;

  const DeviceRuntimeRepositoryImpl(this.datasource);

  @override
  Future<Result<void>> copyToClipboard(String text) async {
    try {
      await datasource.copyToClipboard(text);
      return const Result.success();
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result<String?>> getClipboardData() async {
    try {
      return Result.success(await datasource.getClipboardData());
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }
}
