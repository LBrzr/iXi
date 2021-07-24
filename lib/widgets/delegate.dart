import 'package:flutter/cupertino.dart';

class Delegate extends SliverPersistentHeaderDelegate {

  final double max, min;
  final Widget child;

  Delegate({@required this.max, @required this.min, @required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}