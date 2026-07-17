# Packages — Lane Task Management App

A breakdown of every package used in the project: what it does, why it was chosen, and how it's used.

---

## Production Dependencies

### `flutter_riverpod ^3.0.0`

**What it is:** Reactive state management library for Flutter.

**Why it was chosen:** `setState` works for simple, local UI state — but breaks down the moment multiple screens share state or you need async data. Riverpod solves this by letting you define state providers once, anywhere, and any widget across the app can watch or read from them. When state changes, only the widgets that care about it rebuild — no prop drilling, no `InheritedWidget` boilerplate.

**How we use it:** `AsyncNotifier` (Riverpod 3) for the task list — handles loading, error, and data states automatically. `taskNotifierProvider` is the single source of truth watched by every screen.

```dart
// Subscribe — rebuilds when state changes
final tasks = ref.watch(taskNotifierProvider);

// One-time access — doesn't subscribe
ref.read(taskNotifierProvider.notifier).addTask('New task');
```

**Links:** [pub.dev](https://pub.dev/packages/flutter_riverpod) · [riverpod.dev](https://riverpod.dev/)

---

### `go_router ^16.0.0`

**What it is:** Declarative, URL-based routing library for Flutter.

**Why it was chosen:** Flutter's built-in `Navigator` API is verbose and stateful — managing a navigation stack imperatively gets messy fast. GoRouter brings the URL-based, declarative routing model that web developers already know (similar to React Router). You define routes in one place, navigate with named strings, and pass data cleanly.

**How we use it:**

| API | What it does |
|---|---|
| `context.go('/home')` | Navigate and clear the back stack |
| `context.push('/add-task')` | Push onto the stack (back button returns) |
| `context.pop()` | Go back one screen |
| `state.extra` | Pass objects between screens |

**Links:** [pub.dev](https://pub.dev/packages/go_router)

---

### `dio ^5.0.0`

**What it is:** HTTP client library for Dart.

**Why it was chosen:** The built-in `http` package works, but Dio is significantly more ergonomic for real-world use — cleaner API, built-in interceptors, automatic JSON parsing, better error handling, and easy timeout configuration. Think of it as `axios` for Dart.

**How we use it:** Exclusively in the service layer (`task_service.dart`) to call the task API. The rest of the app never touches Dio directly.

```dart
final response = await dio.get('https://jsonplaceholder.typicode.com/todos');
```

**Links:** [pub.dev](https://pub.dev/packages/dio)

---

### `cupertino_icons ^1.0.8`

**What it is:** iOS-style icon set for Flutter.

**Why it's included:** Standard Flutter template dependency. Provides access to Apple's Cupertino icon set alongside Material icons.

---

## Dev Dependencies

### `flutter_lints ^6.0.0`

**What it is:** Official Flutter lint rules package.

**Why it matters:** Equivalent to ESLint in the JavaScript ecosystem. Enforces consistent code style, catches common mistakes, and surfaces anti-patterns before runtime. The analyzer uses these rules to underline problems directly in VS Code / Android Studio.

```bash
# Check for issues without running the app
flutter analyze
```

---

## Packages Being Added (Next Milestone)

### `drift` (SQLite, recommended for persistence)

**What it is:** Type-safe SQLite wrapper for Flutter with reactive queries and migration support.

**Why Drift over alternatives:**

| Package | Status | Verdict |
|---|---|---|
| **Drift** | Actively maintained | ✅ Recommended — relational, type-safe, reactive |
| `sqflite` | Stable | ✅ Fine, but raw SQL — more boilerplate |
| `objectbox` | Stable | ✅ Fast NoSQL object store with sync |
| `hive` / `isar` | Stalled (2024–2026) | ⚠️ Avoid for new projects |
| `shared_preferences` | Stable | ✅ For simple key-value settings only |

Drift is the right choice for structured task data — it supports complex queries (filter by status, sort by date), handles schema migrations, and works across all Flutter platforms.

**Planned use:** A `LocalTaskService` in the service layer, called from the repository before hitting the network. The task list will load from local DB on startup, sync with the API in the background, and write back on every mutation.

**Links:** [pub.dev](https://pub.dev/packages/drift) · [drift.simonbinder.eu](https://drift.simonbinder.eu/)

---

## How to Add a Package

```bash
# Add from pub.dev
flutter pub add package_name

# Then import in your file
import 'package:package_name/package_name.dart';
```

Check [pub.dev](https://pub.dev) for scores, likes, and maintenance status before adding any new dependency.
