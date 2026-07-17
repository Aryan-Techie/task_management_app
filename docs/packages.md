# 📦 Packages Used

## Production Dependencies

### flutter_riverpod `^3.0.0`
**What it is:** State management library  
**Why we use it:** Instead of `setState` everywhere (which gets messy fast), Riverpod lets you define state once and any widget in the app can watch/read it. When state changes, only the widgets that care about it rebuild.

**Pub.dev:** https://pub.dev/packages/flutter_riverpod  
**Learn more:** https://riverpod.dev/

```yaml
flutter_riverpod: ^3.0.0
```

---

### go_router `^16.0.0`
**What it is:** Navigation / routing library  
**Why we use it:** Flutter's built-in Navigator is verbose. go_router gives us clean named routes (`/home`, `/add-task`, `/task-detail`) similar to how React Router works in web.

**Pub.dev:** https://pub.dev/packages/go_router  
**Key features used:**
- `GoRouter` with named routes
- `context.go()` — navigate and clear back stack
- `context.push()` — navigate and keep back stack
- `context.pop()` — go back
- `state.extra` — pass objects between screens

```yaml
go_router: ^16.0.0
```

---

### dio `^5.0.0`
**What it is:** HTTP client library  
**Why we use it:** Like `axios` in JavaScript. More powerful than Flutter's built-in `http` package — cleaner API, interceptors, easy JSON parsing.

**Pub.dev:** https://pub.dev/packages/dio  
**What we use it for:** Calling `https://jsonplaceholder.typicode.com/todos`

```yaml
dio: ^5.0.0
```

---

## Dev Dependencies

### flutter_lints `^6.0.0`
**What it is:** Linting rules  
**Why we use it:** Like ESLint for JavaScript. Catches bad patterns and enforces code quality automatically. The Dart analyzer uses these rules to underline problems in VS Code.

---

## How to Add More Packages

```bash
# From pub.dev
flutter pub add package_name

# Then import in your file
import 'package:package_name/package_name.dart';
```

---

## Packages We Could Add (Bonus Features)

| Package | Purpose | Bonus Task |
|---|---|---|
| `shared_preferences` | Simple key-value local storage | Offline storage |
| `hive` / `isar` | Full local database | Offline storage |
| `flutter_test` | Widget + unit testing | Unit tests |
| `cached_network_image` | Cache images from network | Performance |
| `shimmer` | Loading skeleton animations | Animations |
| `flutter_animate` | Easy animations | Animations |
