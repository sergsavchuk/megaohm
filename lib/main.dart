import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:megaohm/device/device.dart';
import 'package:megaohm/devices/devices.dart';
import 'package:megaohm/env/env.dart';
import 'package:megaohm_api/megaohm_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  HttpOverrides.global = _BypassSslVerificationOverrides();

  runApp(const MegaohmApp());
}

class MegaohmApp extends StatelessWidget {
  const MegaohmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MegaohmApi(
        baseUrl: 'https://api2.megaohm.ru:44399/test',
        authToken: Env.authToken,
      ),
      child: MaterialApp.router(
        title: 'Megaohm',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: GoRouter(
          initialLocation: '/devices',
          routes: [
            GoRoute(
              path: '/devices',
              builder: (_, __) => const DevicesPage(),
            ),
            GoRoute(
              path: '/device/:id',
              builder: (_, state) =>
                  DevicePage(deviceId: state.pathParameters['id']!),
            ),
          ],
        ),
      ),
    );
  }
}

class _BypassSslVerificationOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
