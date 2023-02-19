import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/bloc/events/rating_event.dart';
import 'package:new_app/bloc/rating_bloc.dart';
import 'package:new_app/bloc/states/menuItem_state.dart';
import 'package:new_app/bloc/states/rating_state.dart';
import 'package:new_app/mainScreen.dart';
import 'package:new_app/models/rating.dart';

import 'bloc/menuItem_bloc.dart';
import 'rating_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue,
            child: const TabBar(
              indicatorPadding: EdgeInsets.all(10),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Text(
                  "Top 5 Crap & Fire",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "What did you eat?",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<MenuItemBloc, MenuItemState>(
                builder: (context, state) {
                  if (state is MenuItemSuccessState) {
                    return MainScreen(state.menuItems);
                  } else if (state is MenuItemLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text("Failure"),
                  );
                },
              ),
              BlocBuilder<MenuItemBloc, MenuItemState>(
                builder: (context, state) {
                  if (state is MenuItemSuccessState) {
                    return RatingPage(
                      menuItems: state.menuItems,
                    );
                  } else if (state is MenuItemLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text("Failure"),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
