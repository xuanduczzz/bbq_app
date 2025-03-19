import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/cubit/Login_cubit/auth_cubit.dart'; // Import file quản lý trạng thái đăng nhập
import 'package:buoi10/page/login_page.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoggedIn) {
                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, size: 50, color: Colors.brown),
                  ),
                  accountName: Text(
                    "ID #${state.fullName}",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  accountEmail: ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Logout", style: TextStyle(color: Colors.white)),
                  ),
                );
              } else {
                return UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, size: 50, color: Colors.brown),
                  ),
                  accountName: const Text(
                    "Guest",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  accountEmail: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
                  ),
                );
              }
            },
          ),
          DrawerItem(icon: Icons.home, text: "Home", onTap: () {}),
          DrawerItem(icon: Icons.list, text: "Reservation", onTap: () {}),
          DrawerItem(icon: Icons.info, text: "About us", onTap: () {}),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({required this.icon, required this.text, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.brown),
      title: Text(text, style: const TextStyle(color: Colors.brown)),
      onTap: onTap,
    );
  }
}
