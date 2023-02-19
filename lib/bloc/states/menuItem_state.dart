import 'package:new_app/models/menuItem.dart';

class MenuItemState {}

class MenuItemSuccessState extends MenuItemState {
  final List<MenuItem> menuItems;

  MenuItemSuccessState(this.menuItems);
}

class MenuItemLoadingState extends MenuItemState {}

class MenuItemFailureState extends MenuItemState {}
