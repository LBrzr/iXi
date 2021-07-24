import 'package:iXi/widgets/customIcons.dart';

class CustomBottomNavItem {
  final int index;
  final CustomIcons fill, outlined;
  CustomBottomNavItem._(this.index, this.fill, this.outlined);
  factory CustomBottomNavItem.home(int index) => CustomBottomNavItem._(index, CustomIcons.home_fill, CustomIcons.home_outlined);
  factory CustomBottomNavItem.search(int index) => CustomBottomNavItem._(index, CustomIcons.search_fill, CustomIcons.search_outlined);
  factory CustomBottomNavItem.stats(int index) => CustomBottomNavItem._(index, CustomIcons.stats_fill, CustomIcons.stats_outlined);
  factory CustomBottomNavItem.person(int index) => CustomBottomNavItem._(index, CustomIcons.person_fill, CustomIcons.person_outlined);
}