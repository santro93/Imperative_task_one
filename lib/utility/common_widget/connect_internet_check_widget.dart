import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imperative_task/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:imperative_task/bloc/connectivity_bloc/connectivity_state.dart';

class ConnectivityGate extends StatelessWidget {
  final Widget child;
  const ConnectivityGate({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivitySuccess && !state.isConnected) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                'No Internet Connection.\nPlease turn on internet to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return child; // Show app only when internet is available
      },
    );
  }
}
