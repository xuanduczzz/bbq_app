import 'package:flutter/material.dart';
import 'package:buoi10/page/sign_up.dart';
import 'package:buoi10/data/user_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main.dart';
import 'package:buoi10/cubit/auth_cubit.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    bool isValid = await UserPrefs.validateUser(
      _phoneController.text,
      _passwordController.text,
    );

    if (isValid) {
      // Lấy thông tin người dùng sau khi đăng nhập thành công
      String? fullName = await UserPrefs.getSavedFullName();
      String? email = await UserPrefs.getSavedEmail();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome, $fullName ($email)')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Logo.png', height: 100),
              const SizedBox(height: 10),
              TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      labelText: 'Phone number', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (bool? value) {}),
                      const Text('Remember me'),
                    ],
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text('Forgot password?')),
                ],
              ),
              const SizedBox(height: 10),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedIn) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OnboardingScreen()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Welcome, ${state.fullName} (${state.email})')),
                    );
                  } else if (state is AuthLoggedOut) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("error")),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                        context.read<AuthCubit>().login(
                          _phoneController.text,
                          _passwordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: const Text('New here? Register',
                    style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}