import 'package:app/navigation/navigation.dart';
import 'package:app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:provider/provider.dart';

import 'blocs/blocs.dart';
import 'config.dart' as config;
import 'pages/pages.dart';
import 'services/services.dart';

Future main() async {
  await DotEnv.load(fileName: ".env");

  // Injects Providers
  runApp(MultiProvider(
    providers: [
      RepositoryProvider<AuthenticationService>(create: (context) => AuthenticationService()),
      ChangeNotifierProvider(create: (context) => CartModel()),
    ],
    child: BlocProvider<AuthenticationBloc>(
      create: (context) {
        final authService = RepositoryProvider.of<AuthenticationService>(context);
        return AuthenticationBloc(authService)..add(AppLoaded());
      },
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Application',
      theme: config.appTheme,
      routes: getRoutes(context),
      initialRoute: IndexPage.routeName,
    );
  }
}
