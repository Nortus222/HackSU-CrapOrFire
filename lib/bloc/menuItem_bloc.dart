import 'package:new_app/bloc/events/menuItem_event.dart';
import 'package:new_app/bloc/states/menuItem_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  MenuItemBloc() : super(MenuItemState()) {
    on<GetMenuItems>(_getMenuItems);
  }

  void _getMenuItems(GetMenuItems event, Emitter<MenuItemState> emit) async {
    emit(MenuItemLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 5))
          .then((value) => emit(MenuItemSuccessState()));
    } catch (error) {
      emit(MenuItemFailureState());
    }
  }
}
