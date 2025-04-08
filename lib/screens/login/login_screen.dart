import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imperative_task/bloc/login/login_bloc.dart';
import 'package:imperative_task/screens/transcation/transaction_list_screen.dart';
import 'package:imperative_task/shared_preference/shared_preferences.dart';
import 'package:imperative_task/utility/common_fun/local_auth_service.dart';
import 'package:imperative_task/utility/common_widget/common_button.dart';
import 'package:imperative_task/utility/constants/app_colors.dart';
import 'package:imperative_task/utility/constants/app_constants.dart';
import 'package:imperative_task/utility/constants/widget_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _logoAnimationController;
  late AnimationController _formAnimationController;
  late Animation<double> _formAnimation;
  @override
  void initState() {
    super.initState();
    userNameController.clear();
    passwordController.clear();
    // Logo fade-in animation
    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Form fade-in animation
    _formAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _formAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _formAnimationController, curve: Curves.easeInOut),
    );

    // Start animations
    _logoAnimationController.forward();
    _formAnimationController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _formAnimationController.dispose();
    userNameController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(left: 16, top: 40),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.transparent),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.appBar1,
                  AppColors.appBarCyant,
                ],
              ),
            ),
          ),
          title: const Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginDataSucessState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => AlertDialog(
                  title: const Text("Enable Biometric?"),
                  content:
                      const Text("Would you like to enable biometric login?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _navigateToNextScreen(context);
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(ctx).pop();
                        final isAuthenticated =
                            await BiometricService.authenticateUser();
                        if (isAuthenticated) {
                          await SharedPreferencesService.saveBool(
                            StorageKeys.isBiometricEnabled,
                            true,
                          );
                          _navigateToNextScreen(context);
                        } else {
                          error(context,
                              title: 'Failed', message: "Biometric Failed");
                        }
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            } else if (state is LoginDataFailedState) {
              error(context, title: 'Error', message: state.message);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceLarge,
                    FadeTransition(
                      opacity: _formAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "User Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          verticalSpaceTiny,
                          _buildTextFormField(
                            controller: userNameController,
                            labelText: 'Enter User Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your User Name';
                              } else if (value.length <= 2) {
                                return 'User Name must be more than 3 characters';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          verticalSpaceMedium,
                          const Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          verticalSpaceTiny,
                          _buildTextFormField(
                            controller: passwordController,
                            labelText: 'Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length <= 3) {
                                return 'Password must be more than 3 characters';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                          verticalSpaceLarge,
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginsProgressState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Center(
                                child: _buildLoginButton(context),
                              );
                            },
                          ),
                          verticalSpaceLarge,
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const TransactionListScreen(),
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
        fillColor: Colors.grey[200],
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

  // Helper method to build the sign-in button with a modern look
  Widget _buildLoginButton(BuildContext context) {
    return CommonButton(
      name: 'Sign In',
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          final userId = userNameController.text;
          final password = passwordController.text;
          context.read<LoginBloc>().add(
                LoginDataEvent(
                  email: userId,
                  password: password,
                ),
              );
        }
      },
    );
  }
}
