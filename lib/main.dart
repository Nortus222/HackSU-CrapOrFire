import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/bloc/events/menuItem_event.dart';
import 'package:new_app/bloc/menuItem_bloc.dart';
import 'package:new_app/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import '/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crap Or Fire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
        BlocProvider<MenuItemBloc>(create: (context) => MenuItemBloc()..add(GetMenuItems()))], 
        child: const HomePage())
    
    );
  }
}