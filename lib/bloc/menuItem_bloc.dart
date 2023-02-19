import 'package:new_app/bloc/events/menuItem_event.dart';
import 'package:new_app/bloc/states/menuItem_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/database.dart';
import 'package:new_app/models/menuItem.dart';
import 'package:new_app/models/rating.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  List<MenuItem> menuItems = [];
  List<Rating> ratings = [];
  MenuItemBloc() : super(MenuItemState()) {
    on<GetMenuItems>(_getMenuItems);
    on<GetMenuItemsWithRating>(_getMenuItemsWithRating);
  }

  void _getMenuItems(GetMenuItems event, Emitter<MenuItemState> emit) async {
    emit(MenuItemLoadingState());
    try {
      if (menuItems.isEmpty) {
        menuItems = await Database.getMenuItems();
      }
      emit(MenuItemSuccessState(menuItems));
    } catch (error) {
      print("ManuItem BloC: $error");
      emit(MenuItemFailureState());
    }
  }

  void _getMenuItemsWithRating(
      GetMenuItemsWithRating event, Emitter<MenuItemState> emit) async {
    emit(MenuItemLoadingState());
    try {
      if (menuItems.isEmpty) {
        menuItems = await Database.getMenuItems();
      }
      if (ratings.isEmpty) {
        ratings = await Database.getRatings();
      }

      for (var item in menuItems) {
        double avg = 0;
        int count = 0;
        ratings.forEach((rating) {
          if (rating.menuItem.title == item.title) {
            avg += rating.rating;
            count++;
          }
        });
        if (avg > 0) {
          item.avgRating = avg / count;
        } else {
          item.avgRating = 3;
        }
      }

      menuItems.sort(((a, b) => a.avgRating!.compareTo(b.avgRating!)));

      List<MenuItem> tmp = [];

      tmp.addAll(menuItems.reversed.take(5));
      tmp.addAll(menuItems.take(5).toList().reversed);

      emit(MenuItemSuccessState(tmp));
    } catch (error) {
      print("ManuItem BloC: $error");
      emit(MenuItemFailureState());
    }
  }
}
