part of 'home_bloc.dart';

abstract class HomeState extends ScreenState {}

// TransactionList
class TransactionListInitial extends HomeState {}

class TransactionListFailedState extends HomeState {}

class TransactionListProgressState extends HomeState {}

class TransactionListSuccessState extends HomeState {
  final List<TransactionsListModel> transactionsListModel;

  TransactionListSuccessState(this.transactionsListModel);
}

class TransactionListDataFailedState extends HomeState {
  final String message;

  TransactionListDataFailedState(this.message);
}
