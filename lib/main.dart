import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imperative_task/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:imperative_task/bloc/connectivity_bloc/connectivity_event.dart';
import 'package:imperative_task/bloc/connectivity_bloc/connectivity_state.dart';
import 'package:imperative_task/bloc/home_bloc/home_bloc.dart';
import 'package:imperative_task/bloc/login/login_bloc.dart';
import 'package:imperative_task/bloc/theme_bloc/theme_bloc.dart';
import 'package:imperative_task/screens/splash_screen.dart';
import 'package:imperative_task/utility/common_widget/connect_internet_check_widget.dart';

import 'bloc/theme_bloc/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<ConnectivityBloc>(
          create: (_) => ConnectivityBloc()..add(CheckConnectivityEvent()),
        ),
      ],
      child: BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectivitySuccess && !state.isConnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No Internet Connection'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: state.themeMode,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              home: const ConnectivityGate(
                child: SplashScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
