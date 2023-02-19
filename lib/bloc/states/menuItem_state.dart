import 'package:new_app/models/menuItem.dart';

class MenuItemState {}

class MenuItemSuccessState extends MenuItemState {
  final List<MenuItem> menuItems;
  final List<MenuItem> menuItemsFull;

  MenuItemSuccessState(this.menuItems, this.menuItemsFull);
}

class MenuItemLoadingState extends MenuItemState {}

class MenuItemFailureState extends MenuItemState {}
