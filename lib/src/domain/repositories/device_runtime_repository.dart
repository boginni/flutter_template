import 'package:error_handler_with_result/error_handler_with_result.dart';

abstract interface class DeviceRuntimeRepository {
  Future<Result<void>> copyToClipboard(String text);

  Future<Result<String?>> getClipboardData();
}
