# Development Checklist — Lane

Tracks what's shipped, what's in progress, and what's next. Keep this in sync with the roadmap.

---

## ✅ Shipped

### Foundation
- [x] Layered architecture — Service → Repository → Provider → UI
- [x] `Task` model with `fromJson`, `toJson`, `copyWith`
- [x] Dio HTTP service layer
- [x] Repository parsing layer
- [x] Riverpod 3 `AsyncNotifier` state management
- [x] GoRouter named routing (all 5 routes)

### Screens
- [x] Splash screen (auto-navigates after delay)
- [x] Home screen — task list with loading / error / empty states
- [x] Add Task screen — form with validation
- [x] Edit Task screen — pre-filled title editing
- [x] Task Detail screen — view + delete

### CRUD Operations
- [x] View tasks (fetched from API)
- [x] Add task (prepended to list, timestamped ID)
- [x] Edit task (title update via copyWith)
- [x] Delete task (filtered from state)
- [x] Toggle completion (flipped via copyWith)

### Widgets
- [x] `TaskCard` — list item with toggle and tap to detail
- [x] `PrimaryButton` — full-width elevated button
- [x] `CustomTextField` — outlined text input with error support
- [x] `LoadingWidget` — centered circular progress indicator
- [x] `ErrorWidgetCustom` — error message display
- [x] `EmptyWidget` — empty state display

### Configuration
- [x] Material 3 light theme
- [x] `AppConstants` — centralised app-wide constants
- [x] `debugShowCheckedModeBanner: false`
- [x] `.gitignore` properly configured

### Documentation
- [x] `README.md`
- [x] `docs/architecture.md`
- [x] `docs/packages.md`
- [x] `docs/roadmap.md`
- [x] `docs/flutter_for_web_devs.md`
- [x] `docs/task_checklist.md` (this file)

---

## 🔴 P0 — Must Do Next

- [ ] **Local persistence (Drift / SQLite)** — tasks lost on app restart
  - [ ] Add `drift` to `pubspec.yaml`
  - [ ] Create `TaskDatabase` with `tasks` table
  - [ ] `LocalTaskService` — read/write from DB
  - [ ] Repository reads from DB on startup, falls back to API
  - [ ] All mutations write to DB (add, edit, delete, toggle)
- [ ] **Dark mode** — `AppTheme.darkTheme` + `ThemeMode.system`
- [ ] **Add task validation feedback** — show inline error message on empty submit

---

## 🟡 P1 — High Value

- [ ] Filter tasks — All / Active / Completed
- [ ] Sort tasks — Newest / Oldest / Alphabetical / Completed Last
- [ ] Task due dates — optional date field with overdue indicator
- [ ] Animations — list slide-in, delete animation, shimmer loading skeleton

---

## 🟢 P2 — Quality

- [ ] Unit tests — `TaskNotifier`, `Task` model, `TaskRepository`
- [ ] Widget tests — `TaskCard`, `HomeScreen` states, `AddTaskScreen` validation
- [ ] Task priority / labels — Low / Medium / High with visual indicators
- [ ] Responsive layout — tablet master-detail split
- [ ] Custom app icon — replace Flutter default

---

## 🐛 Known Issues

| Issue | Status | Notes |
|---|---|---|
| `tasksProvider` in `task_provider.dart` is dead code | Open | Old provider, never used — safe to delete |
| Add/Edit mutations are local only | By design | JSONPlaceholder doesn't persist; local DB (P0) will fix this |
| Splash screen uses hardcoded `2` instead of `AppConstants.splashDuration` | Open | Minor inconsistency, easy fix |
| No `debugShowCheckedModeBanner: false` in tests | N/A | Tests don't use `MaterialApp` directly |
