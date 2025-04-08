import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imperative_task/bloc/connectivity_bloc/connectivity_event.dart';
import 'package:imperative_task/bloc/connectivity_bloc/connectivity_state.dart';
import 'dart:async';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivityEvent>(_onCheckConnectivity);
    on<ConnectivityChangedEvent>(_onConnectivityChanged);

    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      // Check if any of the interfaces has connection
      final isConnected = results.any((r) =>
          r == ConnectivityResult.wifi || r == ConnectivityResult.mobile);
      add(ConnectivityChangedEvent(isConnected));
    });
  }

  Future<void> _onCheckConnectivity(
      CheckConnectivityEvent event, Emitter<ConnectivityState> emit) async {
    final results = await _connectivity.checkConnectivity();
    final isConnected = (results is List<ConnectivityResult>)
        ? results.any((r) =>
            r == ConnectivityResult.wifi || r == ConnectivityResult.mobile)
        : results == ConnectivityResult.wifi ||
            results == ConnectivityResult.mobile;

    emit(ConnectivitySuccess(isConnected));
  }

  void _onConnectivityChanged(
      ConnectivityChangedEvent event, Emitter<ConnectivityState> emit) {
    emit(ConnectivitySuccess(event.isConnected));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
