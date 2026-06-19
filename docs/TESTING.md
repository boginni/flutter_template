# Testing

Mocking is via `mocktail` (no `mockito`/`build_runner`, no `bloc_test`). Golden
images use `golden_toolkit` + `network_image_mock`. `test/` mirrors
`lib/src/` path-for-path.

```
test/
  material_app_testing.dart          shared MaterialApp wrapper for widget/golden tests
  src/domain/repositoires/           NOTE: typo preserved intentionally, match it
  src/external/datasources/
  src/external/repositories/
  src/ui/home/components/(goldens/)
  src/ui/home/pages/(goldens/)
```

Every new repository should get three tests, one per layer:

## 1. Domain — repository interface contract test

Mocks the interface itself. Verifies the shape callers can rely on
(success/failure mapping, call verification), independent of any real
implementation.

```dart
class MockShortenUrlRepository extends Mock implements ShortenUrlRepository {}
class FakeShortenUrlParamsEntity extends Fake implements ShortenUrlParamsEntity {}

void main() {
  late MockShortenUrlRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeShortenUrlParamsEntity());
  });

  setUp(() => repository = MockShortenUrlRepository());

  test(
    'given valid params '
    'when shortenUrl is called '
    'then returns shortened url entity',
    () async {
      final params = FakeShortenUrlParamsEntity();
      final expected = FakeShortenedUrlEntity();
      when(() => repository.shortenUrl(any()))
          .thenAnswer((_) async => Result.success(expected));

      final result = await repository.shortenUrl(params);

      expect(result.isSuccess, true);
      expect(result.success, expected);
      verify(() => repository.shortenUrl(params)).called(1);
    },
  );
}
```

Test names follow `given <precondition> when <action> then <expectation>`.
Register a `Fake` for every params/entity type used with `any()` via
`registerFallbackValue` in `setUpAll`.

## 2. External — repository impl test

Mocks the **datasource**, asserts the impl correctly wraps into `Result`.

```dart
class MockShortenUrlDatasource extends Mock implements ShortenUrlDatasource {}

test('given datasource succeeds when shortenUrl then returns Result.success', () async {
  when(() => datasource.shortenUrl(any())).thenAnswer((_) async => entity);

  final result = await repositoryImpl.shortenUrl(params);

  expect(result.isSuccess, true);
  verifyNoMoreInteractions(datasource);
});

test('given datasource throws when shortenUrl then returns Result.failure', () async {
  when(() => datasource.shortenUrl(any())).thenThrow(const TestFailure());

  final result = await repositoryImpl.shortenUrl(params);

  expect(result.isFailure, true);
  expect(result.failure, isA<TestFailure>());
});
```

`TestFailure` comes from `error_handler_with_result`. Import `flutter_test`
with `hide TestFailure` in any file that also imports
`error_handler_with_result`, since `flutter_test` defines its own
`TestFailure`:

```dart
import 'package:flutter_test/flutter_test.dart' hide TestFailure;
```

## 3. External — datasource test

Mocks `Dio` (and any `*Provider` dependency) directly. Asserts the exact
request made and that failures **propagate by throwing**, not by returning a
`Result` — the datasource layer never constructs `Result`.

```dart
class MockDio extends Mock implements Dio {}

test('given dio throws when shortenUrl then rethrows', () async {
  when(() => dio.post(any(), data: any(named: 'data')))
      .thenThrow(DioException(requestOptions: RequestOptions()));

  expect(() => datasource.shortenUrl(params), throwsA(isA<DioException>()));
});
```

## Widget tests

Pump inside the shared `MaterialAppTesting` wrapper (real theme, l10n
delegates, but `usesCustomFont: false` to avoid a network font fetch):

```dart
await tester.pumpWidget(
  MaterialAppTesting(builder: (context) => ShortenedUrlListTile(entity: entity, onTap: onTap)),
);
```

## Golden tests

```dart
await loadAppFonts();
await mockNetworkImagesFor(() async {
  await tester.pumpWidget(MaterialAppTesting(builder: (_) => widgetUnderTest));
  await expectLater(
    find.byType(RepaintBoundary).first,
    matchesGoldenFile('goldens/<name>.png'),
  );
});
```

For a full-page golden that exercises a controller (e.g.
`home_page_golden_test.dart`), wire a real `Controller` + real `Store`s to
mocked repositories, and set store state directly rather than driving it
through controller calls — this is the accepted pattern for "render this
specific state" golden coverage. Regenerate goldens after an intentional
visual change:

```bash
flutter test --update-goldens
```

## Gap to be aware of

This repo currently has **no dedicated controller unit test** (e.g. no
`home_controller_test.dart`) — controller behavior is only exercised
indirectly through golden tests. When scaffolding a new feature, still write a
controller unit test (mock the repository, assert the store transitions
through `loading → success`/`failure` in the right order) even though the
existing feature doesn't have one — don't treat its absence as the standard to
copy.
