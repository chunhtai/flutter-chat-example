import 'package:chat/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth.dart';
import 'data.dart';
import 'chat_screen.dart';
import 'contacts_nav_rail.dart';
import 'empty_screen.dart';
import 'slide_transition_page.dart';

final GoRouter goRouter = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      bool loggedIn = StreamAuthScope.of(context).currentUser != null;
      if (state.location == '/login') {
        if (loggedIn) {
          return '/';
        }
        return null;
      }
      if (!loggedIn) {
        return '/login';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      ShellRoute(
        builder: (_, GoRouterState state, Widget child) {
          final String contactId = state.location.substring(1);
          return ContactsNavRail(selectedContactId: contactId, child: child);
        },
        routes: <RouteBase>[
          GoRoute(path: '/', redirect: (_, __) => '/0'),
          GoRoute(path: '/:cid', pageBuilder: (_, GoRouterState state) {
            final String cid = state.params['cid']!;
            final LocalKey pageKey = ValueKey(cid);
            if (contacts.containsKey(cid)) {
              return SlideTransitionPage(
                key: pageKey,
                child: ChatScreen(contactId: cid),
              );
            }
            return SlideTransitionPage(key: pageKey, child: const EmptyScreen());
          }),
        ],
      ),
    ]
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamAuthScope(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Chat',
          theme: ThemeData.dark(),
          routerConfig: goRouter,
        )
    );
  }
}
