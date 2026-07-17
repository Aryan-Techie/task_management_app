# ✅ Task Checklist — What's Done & What's Remaining

Based on the internship task PDF requirements.

---

## ✅ DONE

### Folder Structure
- [x] `core/` — theme, constants
- [x] `models/` — Task model
- [x] `services/` — TaskService (HTTP layer)
- [x] `repository/` — TaskRepository (parsing layer)
- [x] `screens/` — all 5 screens
- [x] `widgets/` — all reusable widgets
- [x] `providers/` — Riverpod state
- [x] `routes/` — GoRouter named routes

### State Management
- [x] Riverpod (`AsyncNotifier`) — no excessive setState
- [x] `taskNotifierProvider` watches and manages list state
- [x] All mutations (add/edit/delete/toggle) through notifier

### Screens
- [x] Splash Screen (auto-navigates after 2 seconds)
- [x] Home Screen (list of tasks with loading/error/empty states)
- [x] Add Task Screen
- [x] Edit Task Screen
- [x] Task Detail Screen

### Reusable Widgets
- [x] `PrimaryButton` — full-width elevated button
- [x] `CustomTextField` — outlined text input
- [x] `TaskCard` — list item with toggle & tap to detail
- [x] `LoadingWidget` — circular progress indicator
- [x] `ErrorWidgetCustom` — error message display
- [x] `EmptyWidget` — empty state display

### Data Layer
- [x] `Task` model with `fromJson`, `toJson`, `copyWith`
- [x] Service → Repository → Provider separation
- [x] API: `https://jsonplaceholder.typicode.com/todos`

### Routing
- [x] Named routes with GoRouter
- [x] `state.extra` to pass Task objects between screens
- [x] All 5 routes defined

### UI/UX
- [x] Loading state on home screen
- [x] Error state on home screen
- [x] Empty state on home screen
- [x] AppTheme with Material 3
- [x] App constants (`AppConstants`)
- [x] Delete task from Task Detail screen
- [x] Toggle complete/incomplete

### Features (CRUD)
- [x] View tasks (fetched from API)
- [x] Add task (prepended to top of list)
- [x] Edit task (title updated in state)
- [x] Delete task (removed from state)
- [x] Mark Complete / Incomplete (toggle)

### Documentation
- [x] README.md
- [x] docs/architecture.md
- [x] docs/packages.md
- [x] docs/flutter_for_web_devs.md
- [x] docs/task_checklist.md (this file)

---

## ❌ REMAINING / NOT DONE

### Required (from task PDF)
- [ ] **Themes** — `AppTheme` exists but only `lightTheme`. Dark mode not implemented.
- [ ] **Responsive UI** — No explicit responsive breakpoints (works on phones, not tested on tablet/web layouts)
- [ ] **Git with meaningful commits** — needs to be checked and improved with proper commit history
- [ ] **`AppConstants.splashDuration`** — constant exists but splash screen uses hardcoded `2` instead of using `AppConstants.splashDuration`
- [ ] **Add task validation** — empty check exists but no UI feedback (no error message shown to user)

### Bonus (Optional, adds marks)
- [ ] **Offline Storage** — tasks aren't saved locally. If you close and reopen the app, it re-fetches from API and loses locally added tasks.
- [ ] **Dark Mode** — `AppTheme.darkTheme` not created
- [ ] **Pagination** — currently fetches all 200 todos from the API at once
- [ ] **Filtering** — no way to filter by completed/pending
- [ ] **Sorting** — no sort options
- [ ] **Unit Tests** — no tests written (`test/` folder is empty)
- [ ] **Widget Tests** — none
- [ ] **Animations** — no transition animations or micro-interactions

---

## 🟡 ISSUES / THINGS TO IMPROVE

1. **`task_provider.dart` has a `tasksProvider` that's no longer used** — the app uses `taskNotifierProvider` from `task_notifier.dart` instead. The old `tasksProvider` is dead code.

2. **Add/Edit changes are local only** — Adding a task doesn't actually POST to the API. jsonplaceholder does return fake success responses, but it's not implemented. This is actually acceptable since jsonplaceholder doesn't persist data anyway.

3. **Splash screen doesn't use `AppConstants.splashDuration`** — Small inconsistency.

4. **`main.dart` has no `debugShowCheckedModeBanner: false`** — the red "DEBUG" banner shows in top-right corner.

---

## 📊 Estimated Score (Self-Assessment)

| Category | Max | Estimated |
|---|---|---|
| Project Structure | 20% | ~18% ✅ |
| Flutter Fundamentals | 20% | ~16% ✅ |
| State Management | 15% | ~14% ✅ |
| Clean Code | 15% | ~11% 🟡 |
| Debugging | 10% | — (during review) |
| Architecture | 10% | ~9% ✅ |
| Documentation | 5% | ~5% ✅ |
| Git | 5% | ~3% 🟡 |
| **Total** | **100%** | **~76%** |

*Bonus features would push this higher.*
