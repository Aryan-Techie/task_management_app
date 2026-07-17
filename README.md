# 📋 Task Management App

> Flutter project — built as part of a Flutter internship task.  
> This app lets you view, add, edit, delete, and mark tasks as complete using the [JSONPlaceholder](https://jsonplaceholder.typicode.com/todos) API.

---

## 1. 🗂️ Project Overview

This is a **Task Management App** built with Flutter. It fetches tasks from a public fake REST API, displays them in a list, and lets you manage them locally (add, edit, delete, toggle complete).

I built this to learn Flutter fundamentals — coming from a web background (HTML, CSS, JavaScript), this was my first time working with Dart and Flutter's widget system.

**Live API used:** `https://jsonplaceholder.typicode.com/todos`  
*(Note: jsonplaceholder doesn't actually save your changes — it just pretends to. Add/Edit/Delete only update the in-memory state.)*

---

## 2. ✨ Features

| Feature | Status |
|---|---|
| View all tasks from API | ✅ Done |
| Add a new task | ✅ Done |
| Edit a task's title | ✅ Done |
| Delete a task | ✅ Done |
| Mark task as complete / incomplete | ✅ Done |
| Loading state while fetching | ✅ Done |
| Error state if API fails | ✅ Done |
| Empty state if no tasks | ✅ Done |
| Splash screen | ✅ Done |
| Named routes with GoRouter | ✅ Done |
| Light theme (Material 3) | ✅ Done |
| Dark mode | ❌ Not yet |
| Offline storage | ❌ Not yet |
| Filtering / Sorting | ❌ Not yet |

---

## 3. 🏗️ Architecture

The app uses a **layered / clean architecture** approach:

```
UI Layer (Screens + Widgets)
         ↕
  State Layer (Riverpod Providers)
         ↕
  Repository Layer (Parsing)
         ↕
  Service Layer (HTTP / Dio)
         ↕
  JSONPlaceholder API
```

Each layer has one job and doesn't know about the layers above it.  
→ See [docs/architecture.md](docs/architecture.md) for a detailed explanation.

---

## 4. 📁 Folder Structure

```
lib/
├── main.dart                   # App entry point, sets up ProviderScope + router + theme
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart  # App-wide constants (app name, splash duration)
│   └── theme/
│       └── app_theme.dart      # ThemeData — Material 3 light theme
│
├── models/
│   └── task_model.dart         # Task class with fromJson, toJson, copyWith
│
├── services/
│   └── task_service.dart       # Raw HTTP calls using Dio
│
├── repository/
│   └── task_repository.dart    # Parses HTTP responses into Task objects
│
├── providers/
│   ├── task_provider.dart      # taskRepositoryProvider, taskServiceProvider
│   └── task_notifier.dart      # taskNotifierProvider + TaskNotifier (AsyncNotifier)
│
├── routes/
│   └── app_router.dart         # All named routes using GoRouter
│
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart  # 2-second intro screen → navigates to Home
│   ├── home/
│   │   └── home_screen.dart    # Task list with loading/error/empty states
│   ├── add_task/
│   │   └── add_task_screen.dart
│   ├── edit_task/
│   │   └── edit_task_screen.dart
│   └── task_detail/
│       └── task_detail_screen.dart
│
└── widgets/
    ├── task_card.dart           # ListTile card for each task
    ├── primary_button.dart      # Full-width ElevatedButton wrapper
    ├── custom_text_field.dart   # TextField with OutlineInputBorder
    ├── loading_widget.dart      # CircularProgressIndicator centered
    ├── error_widget_custom.dart # Error message display
    └── empty_widget.dart        # Empty state message
```

---

## 5. 📦 Packages Used

| Package | Version | Purpose |
|---|---|---|
| `flutter_riverpod` | ^3.0.0 | State management |
| `go_router` | ^16.0.0 | Navigation & named routes |
| `dio` | ^5.0.0 | HTTP client for API calls |
| `flutter_lints` | ^6.0.0 | Code quality / linting rules |

→ See [docs/packages.md](docs/packages.md) for detailed explanations of each.

---

## 6. 🚀 Setup Instructions

### Prerequisites
Make sure you have Flutter installed. Check with:
```bash
flutter doctor
```
Everything should show ✅ (at least Flutter and one device target).

### Steps

```bash
# 1. Clone the repository
git clone <your-repo-url>
cd task_management_app

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

To run on a specific device:
```bash
flutter devices          # list available devices
flutter run -d chrome    # run in browser
flutter run -d <device>  # run on specific device
```

### If something breaks
```bash
flutter clean            # clears build cache
flutter pub get          # reinstall packages
flutter run              # try again
```

---

## 7. 🧠 State Management

This app uses **Riverpod 3** with the `AsyncNotifier` pattern.

### Why Riverpod?
- No `setState` for shared state
- Automatically handles loading/error/data states with `AsyncValue`
- Widgets only rebuild when the data they care about changes
- Testable — providers can be overridden in tests

### How it works

```dart
// 1. Define the notifier — holds state + all mutations
class TaskNotifier extends AsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() async {
    // runs on first access — fetches from API
    return ref.read(taskRepositoryProvider).getTasks();
  }

  void addTask(String title) { ... }
  void editTask(int id, String title) { ... }
  void deleteTask(int id) { ... }
  void toggleTask(int id) { ... }
}

// 2. Create the provider
final taskNotifierProvider = AsyncNotifierProvider<TaskNotifier, List<Task>>(TaskNotifier.new);

// 3. Watch in a widget — rebuilds automatically when tasks change
final tasks = ref.watch(taskNotifierProvider);

// 4. Call mutations
ref.read(taskNotifierProvider.notifier).addTask('Buy milk');
```

`ref.watch` = subscribe and rebuild on change  
`ref.read` = one-time access, doesn't rebuild (used inside callbacks)

---

## 8. 🌐 API Information

**Base URL:** `https://jsonplaceholder.typicode.com`  
**Endpoint used:** `GET /todos`  
**Returns:** Array of 200 fake todo items

### Sample Response

```json
{
  "userId": 1,
  "id": 1,
  "title": "delectus aut autem",
  "completed": false
}
```

### How the app handles it

```
GET /todos → Dio response → TaskRepository.getTasks()
  → Task.fromJson(each item) → List<Task> → AsyncData(tasks) → UI
```

> ⚠️ **Important:** JSONPlaceholder is a fake API. POST/PUT/DELETE return
> fake success responses but don't actually persist any data. All add/edit/delete 
> operations only update the **in-memory state** in the app.

---

## 9. Challenges Faced

### 1. Riverpod version confusion
The task instructions used `StateNotifier` / `StateNotifierProvider` syntax, but the project had `flutter_riverpod: ^3.0.0` installed — and **StateNotifier was removed in v3**. I had to figure out that `AsyncNotifier` is the new way.

**What I learned:** Always check the package version before copying code examples. pub.dev shows version-specific documentation.

### 2. `editTask` and `deleteTask` outside the class body
At one point, the methods were accidentally placed outside the closing `}` of the `TaskNotifier` class. Flutter gave confusing errors like "undefined identifier: state". 

**How I debugged:** Read the error carefully, noticed it said `state` wasn't defined (which only exists inside a `Notifier` class), then looked at the class structure and found the methods were outside.

### 3. Broken `createState()` in AddTaskScreen
A partial conversion left the file with a malformed override block that wasn't valid Dart syntax at all. 

**How I debugged:** The Dart analyzer underlined the whole file red. Looked at the specific error line, realised the `createState` override was incomplete.

### 4. Understanding `ConsumerWidget` vs `StatelessWidget`
Took me a while to understand *why* I needed to change `StatelessWidget` to `ConsumerWidget`. 

**The "aha" moment:** `ref` (the Riverpod handle) is only available if you extend a Riverpod widget class. Just like you can only use `this.setState` inside a `StatefulWidget` — `ref` is only inside `ConsumerWidget` / `ConsumerStatefulWidget`.

### 5. `context.pop()` vs `context.go()`
I kept accidentally using `go('/')` when going back, which would clear the whole back stack. `pop()` is the right choice when you just want to go back one screen.

---

## 10. 📚 Learnings

### Flutter Fundamentals
- **Everything is a Widget.** Layout, style, and structure are all widgets nested inside each other.
- **Widget tree rebuilds are controlled.** You decide which widgets watch state and rebuild.
- **`StatelessWidget`** = no internal state (like a pure function component in React)
- **`StatefulWidget`** = has internal state managed with `setState` (like React class components)
- **`ConsumerWidget`** = StatelessWidget that can read Riverpod providers

### Architecture
- **Separation of Concerns** makes code easy to change. When I wanted to swap how data is fetched, only the Service layer needed to change.
- The **Repository pattern** means my UI never directly touches HTTP code.
- **AsyncValue** is brilliant — it wraps loading/error/data states in one type, so you can't accidentally show data when it's still loading.

### State Management  
- `ref.watch` in `build()` method — reactive, rebuilds widget on change
- `ref.read` in callbacks (`onPressed`, etc.) — one-time read, no rebuild
- Never use `ref.watch` inside a callback — it won't work as expected

### Routing
- GoRouter is declarative — define routes once, navigate from anywhere with `context.go()`
- `state.extra` is how you pass complex objects (like a `Task`) to the next screen
- Always cast `state.extra` with `as Task` — it's typed as `Object?`

### Debugging Skills I Picked Up
- Reading Flutter's verbose error messages carefully — the answer is usually in there
- Using `print()` / `debugPrint()` to trace data flow
- Widget Inspector in Flutter DevTools to see the actual widget tree
- `flutter analyze` to catch errors before running

---

## 📁 Documentation Folder

| File | What it covers |
|---|---|
| [docs/architecture.md](docs/architecture.md) | Layered architecture, data flow diagrams |
| [docs/packages.md](docs/packages.md) | Each package explained in detail |
| [docs/flutter_for_web_devs.md](docs/flutter_for_web_devs.md) | Flutter concepts mapped to HTML/CSS/JS |
| [docs/task_checklist.md](docs/task_checklist.md) | What's done ✅ and what's remaining ❌ |

---

## 👨‍💻 About

Built by Aryan as a Flutter internship project.  

> *"The goal is understanding, not just completing the task."*
