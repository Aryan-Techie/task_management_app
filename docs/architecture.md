# Architecture — Lane Task Management App

## Overview

Lane uses a **layered architecture** pattern. Each layer has a single, well-defined responsibility and communicates only with the layer directly adjacent to it. This is the same principle behind clean architecture and separation of concerns — if you swap out one layer, nothing else needs to change.

---

## Layer Diagram

```
┌──────────────────────────────────────────┐
│           UI (Screens / Widgets)         │
│  Renders data. Never calls APIs directly.│
└────────────────────┬─────────────────────┘
                     │ watch / read
┌────────────────────▼─────────────────────┐
│         Riverpod Provider (State)        │
│  Owns the task list. All mutations here. │
│  TaskNotifier (AsyncNotifier<List<Task>>)│
└────────────────────┬─────────────────────┘
                     │ calls
┌────────────────────▼─────────────────────┐
│              Repository                  │
│  Parses raw responses into Task objects. │
│  Source-agnostic: API or local DB today, │
│  anything tomorrow.                      │
└────────────────────┬─────────────────────┘
                     │ calls
┌────────────────────▼─────────────────────┐
│           Service (HTTP / DB)            │
│  Makes the actual Dio request.           │
│  Returns raw Response objects only.      │
└────────────────────┬─────────────────────┘
                     │
┌────────────────────▼─────────────────────┐
│            External Data Source          │
│  Currently: JSONPlaceholder REST API     │
│  Next: Drift (SQLite) for local storage  │
└──────────────────────────────────────────┘
```

---

## Layer Breakdown

### 1. Service Layer — `lib/services/`

Only job: **make HTTP requests**.

- Uses `Dio` to call the API endpoint
- Returns raw `Response` objects — no parsing, no business logic
- Completely unaware of the app's state or models

```dart
// Fetches raw data. Nothing more.
Future<Response> getTasks() async {
  return await dio.get('https://jsonplaceholder.typicode.com/todos');
}
```

**Swapping HTTP clients** (e.g., Dio → http package) is contained entirely to this file.

---

### 2. Repository Layer — `lib/repository/`

Sits between Service and Provider. Its job: **parse raw data into domain models**.

- Calls the service, receives a raw response
- Maps each JSON object into a typed `Task` using `Task.fromJson()`
- When local persistence is added, this layer will also read/write to the local DB

```dart
Future<List<Task>> getTasks() async {
  final response = await service.getTasks();
  return (response.data as List).map((e) => Task.fromJson(e)).toList();
}
```

---

### 3. Provider Layer — `lib/providers/`

The **state owner** of the application.

- Holds the current list of `Task` objects as reactive state
- Exposes methods for every mutation: `addTask`, `editTask`, `deleteTask`, `toggleTask`
- Uses Riverpod 3's `AsyncNotifier` — provides loading/error/data states automatically
- Any widget watching the provider rebuilds when state changes — no manual `setState`

```dart
final taskNotifierProvider =
    AsyncNotifierProvider<TaskNotifier, List<Task>>(TaskNotifier.new);

class TaskNotifier extends AsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() async {
    return ref.read(taskRepositoryProvider).getTasks();
  }

  void addTask(String title) { ... }
  void editTask(int id, String title) { ... }
  void deleteTask(int id) { ... }
  void toggleTask(int id) { ... }
}
```

---

### 4. UI Layer — `lib/screens/` and `lib/widgets/`

Purely responsible for rendering.

- Screens watch `taskNotifierProvider` via `ref.watch()` and rebuild automatically
- Widgets are dumb, reusable components — no state, no business logic
- Calls provider methods via `ref.read()` in response to user actions

---

## Data Flow: Adding a Task

```
User types title → taps "Save"
        ↓
AddTaskScreen calls:
  ref.read(taskNotifierProvider.notifier).addTask(title)
        ↓
TaskNotifier.addTask() creates a new Task object,
prepends it to the current state list
        ↓
HomeScreen is watching taskNotifierProvider
→ Riverpod triggers a rebuild automatically
        ↓
New task appears at the top of the list ✅
```

No page reload. No manual list refresh. Pure reactive state.

---

## Data Flow: Loading Tasks (on App Start)

```
App starts → HomeScreen mounts → ref.watch(taskNotifierProvider)
        ↓
Provider's build() is called for the first time
        ↓
Calls TaskRepository.getTasks()
        ↓
Repository calls TaskService.getTasks() → Dio → API response
        ↓
Repository parses response.data into List<Task>
        ↓
Provider state = AsyncData(tasks)
        ↓
HomeScreen rebuilds, task list renders ✅
```

---

## Why This Structure?

| Concern | Handled by |
|---|---|
| Where does data come from? | Service layer only |
| What shape is the data? | Repository layer only |
| What is the current state? | Provider layer only |
| How is the state displayed? | UI layer only |

If any one of these answers changes, only that layer needs to be updated. The rest of the app is insulated.

**Coming up:** When local persistence is added via Drift, the Repository layer will first check the local DB before hitting the network. The Provider and UI layers will be completely untouched.

---

## Equivalent Web Concepts

| Flutter Layer | Web Equivalent |
|---|---|
| Service | `fetch()` / `axios` call |
| Repository | Data adapter / API parser |
| Provider | Redux store / React Context |
| Screen | React page component |
| Widget | Reusable React component |
