import 'package:go_router/go_router.dart';

import '../models/task_model.dart';
import '../screens/add_task/add_task_screen.dart';
import '../screens/edit_task/edit_task_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/task_detail/task_detail_screen.dart';

final GoRouter appRouter = GoRouter(
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
        final task = state.extra as Task;

        return TaskDetailScreen(
          task: task,
        );
      },
    ),

    GoRoute(
      path: '/edit-task',
      builder: (context, state) {
        final task = state.extra as Task;

        return EditTaskScreen(
          task: task,
        );
      },
    ),
  ],
);