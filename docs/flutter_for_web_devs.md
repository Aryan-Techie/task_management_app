# Flutter for Web Developers

> Coming from HTML, CSS, and JavaScript? Here's how Flutter maps to what you already know.

---

## The Mental Model Shift

In HTML you **describe structure** with tags and **apply style** with CSS.
In Flutter, **everything is a Widget** — structure, style, layout, and animation are all Dart code.

| HTML / CSS / JS | Flutter Equivalent |
|---|---|
| `<div>` | `Container` or `Column` / `Row` |
| `<p>` | `Text` |
| `<button>` | `ElevatedButton` / `TextButton` / `IconButton` |
| `<input type="text">` | `TextField` |
| `<img>` | `Image.network()` / `Image.asset()` |
| `display: flex; flex-direction: column` | `Column(children: [...])` |
| `display: flex; flex-direction: row` | `Row(children: [...])` |
| `padding: 16px` | `Padding(padding: EdgeInsets.all(16))` |
| `margin` | `SizedBox` or `Container(margin: ...)` |
| `border-radius` | `BorderRadius.circular(8)` |
| CSS class / global stylesheet | `ThemeData` in `MaterialApp` |
| `position: fixed` / overlay | `Stack` + `Positioned` |
| React `useState` | `setState` (simple) or Riverpod (preferred) |
| React component | `StatelessWidget` or `StatefulWidget` |
| `import` | `import 'package:...'` |
| `npm install` | `flutter pub add` |
| `package.json` | `pubspec.yaml` |
| `node_modules/` | `.dart_tool/` + pub cache |
| Browser DevTools | Flutter DevTools |
| Browser Elements Inspector | Flutter Widget Inspector |
| Vite hot reload | Flutter Hot Reload (even faster — sub-second) |

---

## Layout

### Flexbox → Column / Row

```css
/* CSS */
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
}
```

```dart
// Flutter equivalent
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // justify-content
  crossAxisAlignment: CrossAxisAlignment.center,     // align-items
  children: [...],
)
```

`mainAxisAlignment` controls the **direction of the Column/Row** (same as `justify-content`).
`crossAxisAlignment` controls the **perpendicular direction** (same as `align-items`).

### Spacing

```dart
// Fixed spacing between items
const SizedBox(height: 16)   // vertical gap
const SizedBox(width: 16)    // horizontal gap

// Equivalent to flex: 1 — takes remaining space
const Spacer()
```

---

## Styling

In CSS you have classes. In Flutter, styling is **inline on the widget**:

```dart
Text(
  'Hello World',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)
```

Global styles (fonts, colors, button shapes) go in `ThemeData` inside `MaterialApp` — that's your global CSS file. Individual widgets inherit from the theme automatically.

---

## State Management

**Vanilla JS (manual DOM update):**
```js
let tasks = [];
function addTask(title) {
  tasks.push({ title, done: false });
  renderList(); // manually update the DOM
}
```

**Flutter with Riverpod (reactive):**
```dart
// State is defined once
final taskNotifierProvider = AsyncNotifierProvider<TaskNotifier, List<Task>>(TaskNotifier.new);

// Widget watches state — rebuilds automatically when state changes
final tasks = ref.watch(taskNotifierProvider);

// Modify state — UI rebuilds without any manual call
ref.read(taskNotifierProvider.notifier).addTask('Buy groceries');
```

No manual DOM update. The UI is a function of state — when state changes, Flutter re-renders the affected widgets. Think React, but compiled to native.

---

## Navigation

| Web | Flutter (GoRouter) |
|---|---|
| `window.location.href = '/home'` | `context.go('/home')` |
| `history.push('/detail')` | `context.push('/detail')` |
| `history.back()` | `context.pop()` |
| Route params / query string | `state.extra` or path params |
| `<Link to="/about">` | `TextButton(onPressed: () => context.go('/about'))` |

---

## Async / Await

Identical to JavaScript — Dart uses the same async/await pattern:

```dart
// JS
async function fetchTasks() {
  const res = await fetch('/api/tasks');
  return res.json();
}

// Dart
Future<List<Task>> fetchTasks() async {
  final response = await dio.get('/api/tasks');
  return (response.data as List).map((e) => Task.fromJson(e)).toList();
}
```

`Future<T>` = `Promise<T>`. `async` and `await` work exactly the same way.

---

## Key Dart Differences from JavaScript

| JavaScript | Dart |
|---|---|
| `let` / `var` | `var` (inferred) |
| `const` | `const` (compile-time) or `final` (runtime set-once) |
| `undefined` / `null` | `null` (explicit null safety with `?`) |
| `string \| null` | `String?` — the `?` means nullable |
| `===` | `==` (Dart has no `===`) |
| `console.log()` | `print()` |
| Template literals `` `Hello ${name}` `` | `'Hello $name'` or `'Hello ${obj.name}'` |
| Array | `List<T>` |
| Object / Map | `Map<String, dynamic>` |
| `interface` / `type` | `class` or `abstract class` |
| Destructuring `const { id, title } = task` | No direct equivalent — use `task.id`, `task.title` |

---

## Null Safety

Dart has **sound null safety** — the compiler enforces it, so null pointer crashes at runtime are nearly impossible:

```dart
String name = 'Aryan';    // never null, guaranteed
String? nickname = null;  // can be null, must be checked

// Safe access
print(nickname?.toUpperCase());  // prints null if nickname is null (no crash)
print(nickname ?? 'No nickname'); // default value if null
```

---

## Key Concepts to Internalize

1. **Widget tree** — everything nests inside everything else. A screen is just a widget that contains other widgets.
2. **BuildContext** — like `this` in a component. Knows where it is in the widget tree. Required for navigation and theme access.
3. **Keys** — help Flutter track widget identity across rebuilds. Same concept as React's `key` prop on list items.
4. **`final` vs `const`** — use `const` for compile-time constants (widget definitions), `final` for values set once at runtime.
5. **Hot Reload** — saves, patches code, and shows changes in under a second without losing state. Hot Restart reloads everything including state.

---

## Resources

### Official
- [Flutter Docs](https://docs.flutter.dev/) — start with "Your first Flutter app"
- [Dart Language Tour](https://dart.dev/language) — covers everything in ~1 hour
- [Flutter Codelabs](https://codelabs.developers.google.com/?cat=flutter) — guided, hands-on projects

### State Management (Riverpod)
- [Riverpod Official Docs](https://riverpod.dev/docs/introduction/getting_started)
- [CodeWithAndrea — Riverpod Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

### Interactive
- [DartPad](https://dartpad.dev/) — run Dart/Flutter in the browser

### Layout Reference
- [Flutter Layout Cheat Sheet](https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e)
