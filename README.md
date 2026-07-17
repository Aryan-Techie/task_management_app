# AROICE Task Management App

A cross-platform mobile task management application built with Flutter. Designed around a clean layered architecture with reactive state management via Riverpod, declarative navigation via GoRouter, and a fully decoupled data layer using Dio.

---

## What It Does

Lane lets you manage your daily tasks on the go. You can view, add, edit, delete, and toggle tasks between complete and incomplete — all with immediate UI feedback and zero page reloads. The app connects to a REST API and keeps state reactively in memory during a session. Local on-device persistence (so your data survives app restarts) is the immediate next milestone.

---

## Features

- **View tasks** — fetched from the API, displayed in a scrollable list
- **Add task** — create new tasks with input validation
- **Edit task** — inline title editing on a dedicated screen
- **Delete task** — remove tasks from the detail screen
- **Toggle completion** — mark tasks complete or incomplete with a single tap
- **Full state handling** — loading, error, and empty states properly handled
- **Splash screen** — branded entry before the home screen
- **Named routing** — clean URL-style navigation with GoRouter

---

## Tech Stack

| Technology | Role |
|---|---|
| Flutter | UI framework (cross-platform — iOS, Android) |
| Dart | Language |
| Riverpod 3 (`AsyncNotifier`) | Reactive state management |
| GoRouter | Declarative named routing |
| Dio | HTTP client |
| Material 3 | Design system |

---

## Architecture

The app follows a strict **layered architecture** — each layer has exactly one responsibility and no layer reaches across boundaries.

```
┌──────────────────────────────────┐
│      UI (Screens / Widgets)      │  ← renders, zero business logic
├──────────────────────────────────┤
│   Riverpod Provider (State)      │  ← owns state + all CRUD mutations
├──────────────────────────────────┤
│          Repository              │  ← parses raw HTTP responses into models
├──────────────────────────────────┤
│        Service (HTTP)            │  ← makes the actual Dio request
├──────────────────────────────────┤
│       External API / DB          │  ← data source (currently JSONPlaceholder)
└──────────────────────────────────┘
```

Practical benefits of this structure:
- Swapping Dio for another HTTP client only touches the service layer
- Adding local persistence only touches the repository layer — the rest of the app is unaware of the change
- The UI never knows or cares where data comes from

---

## Folder Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/app_constants.dart     # App-wide constants (name, durations)
│   └── theme/app_theme.dart             # Material 3 theme definition
├── models/
│   └── task_model.dart                  # Task entity — fromJson, toJson, copyWith
├── services/
│   └── task_service.dart                # Dio HTTP calls — raw response only
├── repository/
│   └── task_repository.dart             # Maps HTTP response → Task objects
├── providers/
│   ├── task_provider.dart               # Provider definitions
│   └── task_notifier.dart               # AsyncNotifier — state + CRUD methods
├── routes/
│   └── app_router.dart                  # All named routes (GoRouter)
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

## State Management

State is managed via Riverpod 3's `AsyncNotifier`. The `TaskNotifier` class owns the task list and exposes all mutations (add, edit, delete, toggle). Every screen that needs tasks simply watches `taskNotifierProvider` and rebuilds automatically when state changes.

```dart
// In a widget's build() — subscribes to changes, rebuilds on update
final tasks = ref.watch(taskNotifierProvider);

// In a callback — one-time call, no subscription
ref.read(taskNotifierProvider.notifier).addTask('Buy groceries');
```

`AsyncValue` wraps state in loading / error / data states — handled cleanly with a single `.when()` call.

---

## Getting Started

```bash
git clone https://github.com/Aryan-Techie/task_management_app.git
cd task_management_app
flutter pub get
flutter run
```

**If the build breaks:**
```bash
flutter clean
flutter pub get
flutter run
```

**Requirements:** Flutter SDK `^3.10.7`. Run `flutter doctor` to verify your environment.

---

## Roadmap

See [`docs/roadmap.md`](docs/roadmap.md) for the full planned feature list.

**Immediate next milestone:** Local on-device persistence via Drift (SQLite) so task data survives app restarts without re-fetching from the API.

---

## Documentation

| Doc | What it covers |
|---|---|
| [`docs/architecture.md`](docs/architecture.md) | Layer breakdown, data flow diagrams |
| [`docs/packages.md`](docs/packages.md) | Every package — what it is and why it was chosen |
| [`docs/roadmap.md`](docs/roadmap.md) | Upcoming features and implementation priorities |
| [`docs/flutter_for_web_devs.md`](docs/flutter_for_web_devs.md) | Flutter concepts mapped to HTML/CSS/JS equivalents |

---

Built by Aryan · 2026
