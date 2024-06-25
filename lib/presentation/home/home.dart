import 'package:flutter/material.dart';

import 'home_component.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints){
          if(constraints.maxWidth < 640){
            return const Center(child: Text('the application not support on your devices, please use web browser'));
          }
           else{
            return const HomeComponent();
          }
        }),
      ),
    );
  }
}