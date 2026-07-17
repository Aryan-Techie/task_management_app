# Task Management App



This was my first Flutter project. I come from a web background (HTML, CSS, some JavaScript) so there was a learning curve, but the structure started making sense once I understood how the layers connect.

---

## Project Overview

The app connects to `https://jsonplaceholder.typicode.com/todos` to get a list of tasks. Since JSONPlaceholder is a fake REST API, it doesn't actually save anything — add/edit/delete only update the local in-memory state. That's fine for this task since the goal was to learn Flutter, not build a real backend.

---

## Features

- View tasks fetched from the API
- Add a new task (with validation)
- Edit a task's title
- Delete a task from the detail screen
- Mark tasks as complete or incomplete
- Loading, error, and empty states handled properly
- Splash screen before home
- Named routes using GoRouter

---

## Folder Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/app_constants.dart   # app name, splash duration
│   └── theme/app_theme.dart           # Material 3 light theme
├── models/
│   └── task_model.dart                # Task class, fromJson, toJson, copyWith
├── services/
│   └── task_service.dart              # HTTP requests using Dio
├── repository/
│   └── task_repository.dart           # Parses response into Task objects
├── providers/
│   ├── task_provider.dart             # service and repository providers
│   └── task_notifier.dart             # state + CRUD logic (AsyncNotifier)
├── routes/
│   └── app_router.dart                # all named routes
├── screens/
│   ├── splash/
│   ├── home/
│   ├── add_task/
│   ├── edit_task/
│   └── task_detail/
└── widgets/
    ├── task_card.dart
    ├── primary_button.dart
    ├── custom_text_field.dart
    ├── loading_widget.dart
    ├── error_widget_custom.dart
    └── empty_widget.dart
```

---

## Architecture

The app is split into layers so each part has one job:

```
UI (Screens / Widgets)
        ↓
  Riverpod Provider  ←  holds and mutates state
        ↓
    Repository       ←  parses the HTTP response
        ↓
     Service         ←  makes the actual API call
        ↓
  JSONPlaceholder API
```

This way the UI never touches HTTP code directly, and if I ever swap Dio for another package, only the service layer changes.

---

## Packages Used

| Package | Why |
|---|---|
| `flutter_riverpod ^3.0.0` | State management |
| `go_router ^16.0.0` | Navigation with named routes |
| `dio ^5.0.0` | HTTP client |
| `flutter_lints ^6.0.0` | Lint rules / code quality |

---

## Setup

```bash
git clone https://github.com/Aryan-Techie/task_management_app.git
cd task_management_app
flutter pub get
flutter run
```

If the build breaks:
```bash
flutter clean
flutter pub get
flutter run
```

---

## State Management

I used Riverpod 3's `AsyncNotifier` pattern. The `TaskNotifier` class holds the task list and all the methods that change it (add, edit, delete, toggle). Any screen that needs tasks just watches `taskNotifierProvider` and rebuilds automatically when something changes.

```dart
// watch = subscribe to changes (use in build)
final tasks = ref.watch(taskNotifierProvider);

// read = one-time access (use inside onPressed etc.)
ref.read(taskNotifierProvider.notifier).addTask('New task');
```

The `AsyncValue` type handles loading/error/data in one place — so you can't accidentally show data while it's still loading.

---

## API

Endpoint: `GET https://jsonplaceholder.typicode.com/todos`

Returns 200 todos. Each one looks like:
```json
{
  "userId": 1,
  "id": 1,
  "title": "buy groceries",
  "completed": false
}
```

The flow: Dio fetches → Repository maps each item with `Task.fromJson()` → Notifier stores the list → UI displays it.

---

## Challenges

**Riverpod v3 breaking change** — The task guide used `StateNotifier` which was removed in Riverpod 3. Took me a bit to realise I needed `AsyncNotifier` instead. Lesson: check the package version before following examples.

**Methods placed outside the class** — `editTask` and `deleteTask` ended up outside the closing brace of `TaskNotifier` at one point. Flutter said `state` was undefined, which was confusing until I looked at the actual class structure.

**ConsumerWidget vs StatelessWidget** — I didn't understand at first why changing to `ConsumerWidget` was necessary just to use `ref`. It clicked when I realised `ref` only exists inside Riverpod's widget types — same reason you can only call `setState` inside a `StatefulWidget`.

**context.pop() vs context.go('/')** — I was using `go('/')` to go back which cleared the navigation stack. `pop()` is the right method when you just want to go back one screen.

---

## Learnings

- Flutter widgets are everything — layout, style, and logic all live in the widget tree
- `ref.watch` in `build()`, `ref.read` in callbacks — mixing them up causes bugs
- `AsyncValue.when(data, loading, error)` is a clean way to handle all three states without lots of if/else
- GoRouter's `state.extra` is how you pass objects between screens
- `flutter analyze` is very useful before running the app

---

## Docs

- [docs/architecture.md](docs/architecture.md) — detailed layer breakdown
- [docs/packages.md](docs/packages.md) — why each package was chosen
- [docs/task_checklist.md](docs/task_checklist.md) — what's done and what's not
- [docs/flutter_for_web_devs.md](docs/flutter_for_web_devs.md) — Flutter mapped to HTML/CSS/JS concepts

---

Built by Aryan — internship Flutter project, 2026.
