# Result

A lightweight, explicit **Result Pattern** for Dart and Flutter.

This package provides a type-safe way to handle successes and failures, replacing traditional `try-catch` flows with a more predictable, value-based approach.

## Features

* ✅ **Explicit Checking:** Use `isSuccess` and `isFailure` for clear, readable logic.
* ✅ **Safe Capturing:** Use `Result.capture` to automatically wrap `Future` or synchronous blocks.
* ✅ **Failure Mapping:** Automatically converts caught exceptions into `Failure` objects.
* ✅ **Simple API:** No complex functional programming boilerplate—just clean Dart.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  error_handler_with_result: ^1.0.0
```

## Usage

### Handling Results
The core philosophy of this package is to use explicit checks to handle your data.

```dart
final result = await Result.capture<User>(() => api.fetchUser());

if (result.isSuccess) {
  // Access the success value safely
  final user = result.success;
  print('Loaded: ${user.name}');
} else {
  // Access the failure object
  final failure = result.failure;
  print('Error: ${failure.message}');
}
```

### Creating Results
You can manually wrap values or use the provided extension:

```dart
// Using constructors
final success = Result<int>.success(42);
final failure = Result<int>.failure(ServerFailure());

// Using the .toResult() extension
final myResult = someObject.toResult<MyType>();
```

### How `capture` Works
The `capture` method handles the `try-catch` boilerplate for you. If an error is thrown inside the function, it is caught and converted into a `Failure`:

1. If the error is already a `Failure` type, it is returned directly.
2. Otherwise, it is wrapped in an `UnknownFailure` along with the `StackTrace`.
