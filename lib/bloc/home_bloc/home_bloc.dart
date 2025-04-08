import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:imperative_task/bloc/base_bloc/base_bloc.dart';
import 'package:imperative_task/model/transcation/transactions_list_model.dart';
import 'package:imperative_task/repository/transaction_repo/transcation_repo.dart';
import '../base_bloc/screen_state.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(TransactionListInitial());

  @override
  HomeState getErrorState() => TransactionListFailedState();

  @override
  Stream<HomeState> handleEvents(HomeEvent event) async* {
    if (event is TranscationListEvent) {
      yield* _handleTranscationListEvent(event);
    }
  }

  Stream<HomeState> _handleTranscationListEvent(
      TranscationListEvent event) async* {
    yield TransactionListProgressState();
    try {
      final Response response = await TranscationRepo()
          .getTransactionList(); // Use correct API method here
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final List<TransactionsListModel> expenses = jsonList
            .map((json) =>
                TransactionsListModel.fromJson(json as Map<String, dynamic>))
            .toList();
       
        yield TransactionListSuccessState(expenses);
      }
    } catch (ex) {
      log("TransactionListFailedState ${ex.toString()}");
      yield TransactionListDataFailedState(ex.toString());
    }
  }
}
