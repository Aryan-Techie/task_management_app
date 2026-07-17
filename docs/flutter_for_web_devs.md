# 🌐 Flutter for Web Developers

> You know HTML, CSS, and a bit of JS. Here's how Flutter maps to what you already know.

---

## The Mental Model Shift

In HTML you **describe structure** with tags and **style** with CSS.  
In Flutter, **everything is a Widget** — structure, style, and layout are all code.

| HTML/CSS/JS | Flutter Equivalent |
|---|---|
| `<div>` | `Container` or `Column` / `Row` |
| `<p>` | `Text` |
| `<button>` | `ElevatedButton` / `TextButton` |
| `<input type="text">` | `TextField` |
| `<img>` | `Image` |
| `display: flex; flex-direction: column` | `Column(children: [...])` |
| `display: flex; flex-direction: row` | `Row(children: [...])` |
| `padding: 16px` | `Padding(padding: EdgeInsets.all(16))` |
| `margin` | `SizedBox` or `Container(margin: ...)` |
| `border-radius` | `BorderRadius.circular(8)` |
| CSS class / stylesheet | `ThemeData` / `TextStyle` |
| `position: fixed` | `Stack` + `Positioned` |
| React `useState` | `setState` (simple) or Riverpod (preferred) |
| React component | `StatelessWidget` or `StatefulWidget` |
| `import` | `import 'package:...'` |
| `npm install` | `flutter pub add` |
| `package.json` | `pubspec.yaml` |
| `node_modules` | `.dart_tool/` + pub cache |
| Browser DevTools | Flutter DevTools |
| Browser Inspector | Flutter Widget Inspector |
| Hot reload (Vite) | Flutter Hot Reload (same concept, even faster) |

---

## Layout Differences

### Flexbox → Column/Row

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
// Flutter
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [...],
)
```

`mainAxisAlignment` = `justify-content` (direction of the column/row)  
`crossAxisAlignment` = `align-items` (perpendicular direction)

---

## Styling Differences

In CSS you have classes. In Flutter, styling is **inline** on the widget:

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

Global styles go in `ThemeData` in `main.dart` — that's like your global CSS file.

---

## State Management

In vanilla JS you might do:
```js
let count = 0;
document.getElementById('btn').onclick = () => {
  count++;
  document.getElementById('display').innerText = count;
};
```

In Flutter with Riverpod, you **watch** state and the UI rebuilds automatically:
```dart
// Define state
final countProvider = StateProvider<int>((ref) => 0);

// Use in widget — rebuilds when count changes
final count = ref.watch(countProvider);
Text('$count')

// Modify state
ref.read(countProvider.notifier).state++;
```

No manual DOM updates. Think of it like React.

---

## Navigation

| Web | Flutter (GoRouter) |
|---|---|
| `window.location.href = '/about'` | `context.go('/about')` |
| `history.push('/detail')` | `context.push('/detail')` |
| `history.back()` | `context.pop()` |
| Route params `?id=5` | `state.extra` or path params |
| `<Link to="/about">` | `TextButton(onPressed: () => context.go('/about'))` |

---

## Key Flutter Concepts to Master Next

1. **Widget tree** — everything nests inside everything else
2. **BuildContext** — like `this` in a component, knows its position in the tree
3. **Keys** — help Flutter track widget identity (like React's `key` prop)
4. **async/await** — same as JS, already familiar!
5. **Null safety** — `String?` means nullable, `String` means never null
6. **`final` vs `const`** — `const` = compile-time constant, `final` = set once at runtime

---

## 🎯 Best Resources

### For Beginners (Start Here)
- [Flutter Official Docs](https://docs.flutter.dev/) — genuinely excellent, start with "Your first Flutter app"
- [Flutter Codelabs](https://codelabs.developers.google.com/?cat=flutter) — hands-on guided projects
- [Dart Language Tour](https://dart.dev/language) — read this first, takes 1 hour

### YouTube Channels
- **Rivaan Ranawat** — Best Flutter course in Hindi/English, very practical
- **Net Ninja Flutter** — Great for beginners coming from web
- **Robert Brunhage** — Clean architecture & best practices
- **Flutter Mapp** — State management focused

### For State Management (Riverpod)
- [Riverpod Official Docs](https://riverpod.dev/docs/introduction/getting_started) — has interactive examples
- [CodeWithAndrea - Riverpod course](https://codewithandrea.com/articles/flutter-state-management-riverpod/) — best free content on Riverpod

### Interactive
- [DartPad](https://dartpad.dev/) — Run Dart/Flutter in browser, like CodePen for Flutter

### Cheat Sheets
- [Flutter Layout Cheat Sheet](https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e) — bookmark this
- [Riverpod Cheat Sheet](https://riverpod.dev/docs/concepts/reading) — ref.watch vs ref.read explained

---

## 🏆 Learning Tricks (Web Dev → Flutter)

1. **Think in trees, not in pages.** Every screen is a tree of nested widgets.
2. **Read the errors.** Flutter errors are verbose but very helpful. The last line usually tells you exactly what's wrong.
3. **Use Widget Inspector** (Flutter DevTools → Inspector) exactly like Chrome's Elements tab.
4. **Hot Reload is your best friend.** Save → see changes in <1 second.
5. **Don't memorize widget properties.** Use VS Code IntelliSense. Type `Column(` and let it autocomplete.
6. **pub.dev = npm registry.** Search packages there, look at pub points and likes.
7. **Read source code.** Ctrl+click any Flutter widget to see how it's built.
