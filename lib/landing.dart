import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/bloc/events/rating_event.dart';
import 'package:new_app/bloc/rating_bloc.dart';
import 'package:new_app/bloc/states/menuItem_state.dart';
import 'package:new_app/bloc/states/rating_state.dart';
import 'package:new_app/models/rating.dart';

import 'bloc/menuItem_bloc.dart';

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
              indicatorPadding: EdgeInsets.all(5),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Text("Top 5"),
                Text("what did you eat?"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<MenuItemBloc, MenuItemState>(
                builder: (context, state) {
                  if (state is MenuItemSuccessState) {
                    return ListView.builder(
                        itemCount: state.menuItems.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                              title: Text(state.menuItems[index].title));
                        }));
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
              BlocBuilder<RatingBloc, RatingState>(builder: (context, state) {
                if (state is RatingSuccessState) {
                  return ListView.builder(
                      itemCount: state.ratings.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.ratings.length) {
                          return IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: () =>
                                context.read<RatingBloc>().add(UploadRating([
                                      Rating(
                                          state.ratings.first.menuItem,
                                          Random().nextInt(5).toDouble(),
                                          DateTime.now())
                                    ])),
                          );
                        }
                        return ListTile(
                          title: Text(state.ratings[index].rating.toString()),
                        );
                      });
                } else if (state is RatingLoadingstate) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text("Failure"),
                );
              })
            ],
          ),
        ));
  }
}
