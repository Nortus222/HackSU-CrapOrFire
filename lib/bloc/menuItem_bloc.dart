import 'package:new_app/bloc/events/menuItem_event.dart';
import 'package:new_app/bloc/states/menuItem_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/database.dart';
import 'package:new_app/models/menuItem.dart';

import '../firebase_options.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  List<MenuItem> menuItems = [];
  MenuItemBloc() : super(MenuItemState()) {
    on<GetMenuItems>(_getMenuItems);
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
}
