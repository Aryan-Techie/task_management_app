// all the named routes are defined here in one place
// using GoRouter instead of Flutter's built-in Navigator because it's cleaner
// and supports named routes properly

// to navigate: context.go('/path') or context.push('/path')
// to pass data between screens: use context.push('/path', extra: object)
// and then read it with state.extra as Task on the other side

import 'package:go_router/go_router.dart';

import '../models/task_model.dart';
import '../screens/add_task/add_task_screen.dart';
import '../screens/edit_task/edit_task_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/task_detail/task_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  // app always opens on splash first
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/add-task',
      builder: (context, state) => const AddTaskScreen(),
    ),

    GoRoute(
      path: '/task-detail',
      builder: (context, state) {
        // the Task object is passed via state.extra when navigating here
        // casting it because state.extra is typed as Object?
        final task = state.extra as Task;

        return TaskDetailScreen(
          task: task,
        );
      },
    ),

    GoRoute(
      path: '/edit-task',
      builder: (context, state) {
        // same pattern — task comes in through extra
        final task = state.extra as Task;

        return EditTaskScreen(
          task: task,
        );
      },
    ),
  ],
);