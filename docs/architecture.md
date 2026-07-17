# 🏗️ Architecture — Task Management App

## Overview

This app follows a **layered architecture** pattern. Think of it like building a house:
- The **foundation** = Models
- The **plumbing** = Service + Repository
- The **walls** = Providers (state)
- The **rooms you see** = Screens
- The **furniture** = Widgets

---

## The 3 Data Layers

```
UI (Screens/Widgets)
        ↕
  Provider (State)
        ↕
   Repository
        ↕
    Service (HTTP)
        ↕
  jsonplaceholder API
```

### 1. Service Layer (`lib/services/`)
- Only job: **make HTTP requests**
- Uses `Dio` to call the API
- Returns raw `Response` objects
- Knows nothing about the app

```dart
// It just fetches. That's it.
Future<Response> getTasks() async {
  return await dio.get('https://jsonplaceholder.typicode.com/todos');
}
```

### 2. Repository Layer (`lib/repository/`)
- Sits between Service and Provider
- **Parses** the raw HTTP response into `Task` objects
- If you ever switch from Dio to http package, only this layer changes
- Knows about Models, not about the UI

```dart
Future<List<Task>> getTasks() async {
  final response = await service.getTasks();
  return (response.data as List).map((e) => Task.fromJson(e)).toList();
}
```

### 3. Provider Layer (`lib/providers/`)
- The **brain** of the app
- Holds the current list of tasks in memory
- Every mutation (add, edit, delete, toggle) happens here
- UI watches this and rebuilds automatically when state changes

---

## Why This Structure?

Coming from HTML/CSS/JS: imagine jQuery spaghetti vs React components with state. This is the Flutter equivalent of proper state management. Each layer has **one job** and doesn't know about the others. That's called **Separation of Concerns**.

| Layer | Equivalent in Web |
|---|---|
| Service | `fetch()` or `axios` call |
| Repository | Data parsing / adapter |
| Provider | React state / Redux store |
| Screen | React component / page |
| Widget | Reusable React component |

---

## Data Flow: Adding a Task

```
User types title → taps "Save Task"
        ↓
AddTaskScreen calls ref.read(taskNotifierProvider.notifier).addTask(title)
        ↓
TaskNotifier.addTask() creates new Task and prepends to state
        ↓
HomeScreen is watching taskNotifierProvider → automatically rebuilds
        ↓
New task appears at top of list ✅
```

No page reload. No manual setState for the list. Just reactive state.
