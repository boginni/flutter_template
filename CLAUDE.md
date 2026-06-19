# CLAUDE.md

This repository is a **Flutter template**: Domain-first Clean Architecture with a
ChangeNotifier-based "BLoC-lite" pattern (no `bloc` package, no code generation).
It is meant to be forked/copied as the starting point for new Flutter apps and
technical-test projects, so keep changes consistent with the conventions below —
that consistency is the entire value of the template.

Read this file first. Deeper detail lives in `docs/`:

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — layers, data flow, DI, routing
- [docs/CONVENTIONS.md](docs/CONVENTIONS.md) — naming, folder layout, style rules
- [docs/TESTING.md](docs/TESTING.md) — test conventions, mocking, goldens
- [docs/PACKAGES.md](docs/PACKAGES.md) — what each local package under `packages/` is for

Two scaffolding skills encode the workflows below as repeatable steps:
`.claude/skills/new-feature` and `.claude/skills/new-package`.

## Quick orientation

```
lib/src/
  domain/      pure Dart contracts: entities, params, repository interfaces. No Flutter, no dio.
  external/    implementations: datasources, models, repository impls, interceptors, providers.
  ui/          Flutter: pages, components, controllers/stores, routes, DI wiring.
packages/      local workspace packages (design system, l10n, assets, router, error handling)
test/          mirrors lib/src/, plus golden files
```

Data flow is always one direction:

```
Page → Controller → Store (ChangeNotifier + state) 
Controller → Repository (domain interface) → RepositoryImpl (external) → Datasource → Dio / Provider
```

The domain layer never imports Flutter or `dio`. The UI layer never imports
`external/` directly — it only depends on domain interfaces, resolved through
`AppDependencies` (get_it).

## Commands

```bash
flutter pub get                 # fetch deps for root + all workspace packages
flutter test                    # run all tests (root + packages/*)
flutter test --update-goldens   # regenerate golden images after an intentional UI change
flutter analyze                 # static analysis (flutter_lints, see analysis_options.yaml)
flutter run --dart-define=BASE_URL=... --dart-define=IS_PRODUCTION=false
```

Environment values (`lib/src/domain/environment.dart`) are read via
`String.fromEnvironment` / `bool.fromEnvironment`, i.e. `--dart-define`, **not**
a `.env` loader — `example.env` documents the shape of expected config but most
of its keys (auth/location mocks) are currently unused placeholders. Don't
assume a dotenv package is wired up.

## Adding a feature — in one sentence

Entity → Params → Repository interface (domain) → Model → Datasource →
RepositoryImpl (external) → register both in `AppDependencies._init` → Store/state
→ Controller → Page/Components (ui) → RouteConfig/Route → register the route in
`AppRoutes.routes` → tests at each layer. Use the `new-feature` skill to do this
end-to-end instead of doing it by hand.

## Non-negotiables when writing code here

- **Imports are relative within `lib/`** (`prefer_relative_imports` is enforced).
- Repository interfaces are `abstract interface class` in `domain/`; implementations
  live in `external/` and are named `<X>RepositoryImpl`.
- Repository methods return `Future<Result<T>>` from `error_handler_with_result`.
  Datasources throw; repository impls are the only place that catches and
  converts to `Result` (`Result.success(...)` / `Result.failureFromCatch(e, s)`).
- Never call `Failure.throwError()` inside a repository or datasource — that's a
  UI/controller-layer decision after inspecting `result.isFailure`.
- UI state is a `sealed class` with named factory constructors per variant
  (`Loading`, `Failure`, `Success`, `Empty`, ...), rendered with an exhaustive
  `switch` expression — never `if/else` chains on state.
- Stores extend `ChangeNotifier implements ValueListenable<XState>`; only a
  Store calls `notifyListeners()` (via its `state` setter). Controllers mutate
  `store.state`, they never call `notifyListeners()` themselves.
- Widgets that only render data take primitives/callbacks and are `StatelessWidget`
  — no controller/store access inside a `*Component`.
- New dependencies are registered once, in `AppDependencies._init`, at the
  `// --` marker: `registerFactory` for datasources/repositories (bind repos to
  their **interface** type), `registerSingleton` for shared long-lived instances.
- New screens get a `<Feature>RouteConfig extends AppRouteConfig` +
  `<Feature>Route extends AppRoute` pair (see `lib/src/ui/shell/shell_routes.dart`),
  registered as a `CustomGoRoute(config: ...)` in `lib/src/ui/app/app_routes.dart`.
- Every new repository gets a domain-level interface test (mock the interface)
  **and** an external-level impl test (mock the datasource, assert `Result`
  mapping) **and** a datasource test (mock `Dio`, assert throwing behavior).
- Don't add `bloc`, `provider`, `riverpod`, `freezed`, or `json_serializable` —
  the template deliberately uses hand-rolled `ChangeNotifier` state and hand-rolled
  JSON (de)serialization on `*Model` classes. If a real project needs those, that's
  a decision to make explicitly when forking the template, not silently.

## Known template quirks (don't "fix" these without being asked)

- `test/src/domain/repositoires/` has a typo in the folder name — preserved for
  now so paths stay predictable; match it if adding sibling tests.
- `analysis_options.yaml` excludes a couple of package paths that don't exist in
  this repo (`packages/recup_icons/**`, `packages/m3_widgets/**`) — leftovers
  from the source template, harmless.
- `lib/src/ui/shell/shell_dependencies.dart` defines an unused example scoped
  `GetIt` instance — it demonstrates the "scoped DI container" pattern for a
  feature that needs one; most features just use the root `AppDependencies`.
