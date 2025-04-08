import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imperative_task/bloc/home_bloc/home_bloc.dart';
import 'package:imperative_task/bloc/theme_bloc/theme_bloc.dart';
import 'package:imperative_task/bloc/theme_bloc/theme_event.dart';
import 'package:imperative_task/model/transcation/transactions_list_model.dart';
import 'package:imperative_task/screens/login/login_screen.dart';
import 'package:imperative_task/shared_preference/shared_preferences.dart';
import 'package:imperative_task/utility/common_fun/common_function.dart';
import 'package:imperative_task/utility/constants/widget_utils.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  List<TransactionsListModel> _filteredTransactions = [];
  final TextEditingController _searchController = TextEditingController();
  int? _expandedIndex;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(TranscationListEvent());
    _searchController.addListener(() {
      final state = context.read<HomeBloc>().state;
      if (state is TransactionListSuccessState) {
        _filterTransactions(
            _searchController.text, state.transactionsListModel);
      }
    });
  }

// Toggle the expanded state for each card
  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null;
      } else {
        _expandedIndex = index;
      }
    });
  }

  void _filterTransactions(
      String query, List<TransactionsListModel> transactions) {
    setState(() {
      _filteredTransactions = transactions.where((tx) {
        return tx.category?.toLowerCase().contains(query.toLowerCase()) ??
            false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transactions",
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                  child: const Icon(
                    Icons.dark_mode,
                  ),
                ),
                horizontalSpaceLarge,
                GestureDetector(
                  onTap: () async {
                    await SharedPreferencesService.deleteAll();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is TransactionListProgressState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionListSuccessState) {
            final transactions = state.transactionsListModel;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  _buildTextFormField(
                    controller: _searchController,
                    labelText: 'Search by Category',
                    validator: (_) => null,
                    keyboardType: TextInputType.text,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredTransactions.isEmpty &&
                              _searchController.text.isEmpty
                          ? transactions.length
                          : _filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final tx = _filteredTransactions.isEmpty &&
                                _searchController.text.isEmpty
                            ? transactions[index]
                            : _filteredTransactions[index];
                        bool isExpanded = _expandedIndex == index;
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () => _toggleExpansion(index),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpaceSmall,
                                ListTile(
                                  title: Text(tx.category ?? "No Title"),
                                  trailing:
                                      Text(AppFunctions().convertDateToDDMMYYYY(
                                            tx.date.toString(),
                                          ) ??
                                          ""),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  child: isExpanded
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Description: ${tx.description}',
                                              ),
                                              Text(
                                                'Amount: ₹${tx.amount}',
                                              ),
                                              verticalSpaceMedium,
                                            ],
                                          ),
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is TransactionListDataFailedState) {
            return Center(child: Text("Failed: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // TextFormField with custom style
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required FormFieldValidator<String> validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }
}
