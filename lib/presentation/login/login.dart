

import 'package:flutter/material.dart';

import 'login_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints){
          if(constraints.maxWidth < 640){
            return const Center(child: Text('the application not support on your devices, please use web browser'));
          }
           else{
            return const LoginComponent();
          }
        }),
      ),
    );
  }
}