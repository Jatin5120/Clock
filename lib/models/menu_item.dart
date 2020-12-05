import 'package:flutter/foundation.dart';
import '../data/enums.dart';

class MenuItem extends ChangeNotifier {
  MenuType menuType;
  String title;
  String image;

  MenuItem(this.menuType, {this.title, this.image});

  updateMenu(MenuItem menuItem) {
    this.menuType = menuItem.menuType;
    this.title = menuItem.title;
    this.image = menuItem.image;

    /// Very important
    notifyListeners();
  }
}