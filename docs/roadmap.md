# Roadmap — Lane Task Management App

A prioritised list of upcoming features, improvements, and known issues. Items at the top are the most immediate priorities.

---

## 🔴 P0 — Must Do Next

### 1. Local On-Device Persistence (Drift / SQLite)

**Why it matters:** Right now, every task added, edited, or deleted lives only in memory. If the app is closed or the phone restarts, all local changes are wiped and the app re-fetches from the API. This is the most critical missing feature for a usable task manager.

**The plan:**
- Add `drift` package (type-safe SQLite wrapper)
- Create a `TaskDatabase` with a `tasks` table matching the `Task` model
- Add a `LocalTaskService` or update the repository to read from DB first
- On first load: fetch from API, write to local DB
- On mutations (add/edit/delete/toggle): update both in-memory state and DB
- On subsequent loads: serve from local DB, optionally sync with API in background

**Libraries evaluated:**

| Package | Verdict |
|---|---|
| `drift` | ✅ Recommended — type-safe, reactive, actively maintained |
| `sqflite` | ✅ Good alternative — raw SQL, less magic |
| `objectbox` | ✅ High-performance NoSQL option |
| `hive` / `isar` | ⚠️ Avoid — development stalled since 2024 |
| `shared_preferences` | ❌ Not suitable for structured list data |

**Implementation scope:** Service + Repository layers only. Providers and UI are untouched.

---

### 2. Dark Mode

**Why it matters:** `AppTheme.lightTheme` is implemented but there is no `darkTheme`. Most users expect system-level dark mode support.

**The plan:**
- Add `AppTheme.darkTheme` with a matching Material 3 dark color scheme
- Pass `darkTheme: AppTheme.darkTheme` and `themeMode: ThemeMode.system` to `MaterialApp.router`
- No extra packages needed

---

### 3. Add Task Validation Feedback

**Why it matters:** Empty-string validation runs but no error message is shown to the user. The user doesn't know why the form didn't submit.

**The plan:**
- Show an inline error below the text field when the user submits an empty title
- Use `CustomTextField`'s existing `errorText` parameter (already wired up in the widget)

---

## 🟡 P1 — High Value, Near Term

### 4. Filter Tasks

Allow users to filter the task list by status: **All**, **Active**, **Completed**.

- Add a filter toggle (SegmentedButton or TabBar) at the top of the home screen
- Filter is applied to the in-memory list — no extra API call
- State: a simple `filterProvider` (StateProvider<FilterType>) alongside the task list

---

### 5. Sort Tasks

Let users sort by: **Newest First**, **Oldest First**, **Alphabetical**, **Completed Last**.

- Sort controls in the home screen app bar or a bottom sheet
- Sorting is applied reactively to the provider state

---

### 6. Task Due Dates

Add an optional due date field to each task. Display an overdue badge on tasks past their deadline.

- Update `Task` model: add `dueDate DateTime?`
- Add a date picker to `AddTaskScreen` and `EditTaskScreen`
- Show visual indicator on `TaskCard` for overdue items

---

### 7. Animations & Micro-interactions

The app currently has no motion. Add:
- List item slide-in on first load (`flutter_animate` package)
- Task card deletion animation (animate out before removing from list)
- Smooth page transitions between screens (GoRouter's `CustomTransitionPage`)
- Loading skeleton instead of a spinner (`shimmer` package)

---

## 🟢 P2 — Quality & Polish

### 8. Unit Tests

- `TaskNotifier` methods (add, edit, delete, toggle) are pure logic — easy to unit test
- `Task.fromJson()` and `Task.copyWith()` — model tests
- `TaskRepository` — test with a mock service
- Target: 80%+ coverage on the provider and model layers

**Package:** `flutter_test` (already a dev dependency), `mocktail` for mocks

---

### 9. Widget Tests

- `TaskCard` renders title and completion status correctly
- `HomeScreen` renders loading/error/empty states
- `AddTaskScreen` validates and calls notifier on submit

---

### 10. Task Priority / Labels

- Add a `priority` field (Low / Medium / High) to the `Task` model
- Visual indicator on `TaskCard` (colored left border or badge)
- Filter and sort by priority

---

### 11. Responsive Layout (Tablet / Web)

- Current layout is phone-only
- Add breakpoints: phones use the current single-column list; tablets use a master-detail split layout
- Use `LayoutBuilder` or `adaptive_scaffold` package

---

### 12. App Icon & Name

- Replace the default Flutter icon with a proper app icon for Lane
- Use `flutter_launcher_icons` to generate icons for all platforms from a single source image

---

## ✅ Done

- [x] Layered architecture (Service → Repository → Provider → UI)
- [x] Riverpod 3 `AsyncNotifier` state management
- [x] Full CRUD: view, add, edit, delete, toggle
- [x] Named routing with GoRouter
- [x] Loading, error, and empty states on home screen
- [x] Reusable widget library (TaskCard, PrimaryButton, CustomTextField, etc.)
- [x] Splash screen
- [x] Material 3 light theme
- [x] `debugShowCheckedModeBanner: false`
