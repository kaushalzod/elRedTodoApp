import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeAppBarSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double appBarHeight;
  final double? safeAreaHeight;
  double? donePercentage;
  final int? personalCount;
  final int? businessCount;
  String imageUrl = "https://i.ibb.co/dPzV515/elred.png";
  final Function()? menuOnTap;

  HomeAppBarSliver(
      {required this.expandedHeight,
      required this.appBarHeight,
      this.safeAreaHeight,
      this.donePercentage,
      this.menuOnTap,
      this.businessCount,
      this.personalCount});

  TextStyle textStyle(double shrinkOffset, {double fontSize = 10}) => TextStyle(
      color: Colors.white12.withOpacity(contentOpacity(shrinkOffset)),
      fontSize: fontSize);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
        Positioned(
          top: safeAreaHeight ?? 24,
          child: SizedBox(
            height: appBarHeight,
            child: Row(children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, color: Colors.white),
              ),
              const SizedBox(width: 20),
              shrinkOffset > 40
                  ? const Text(
                      "Your Things",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox.shrink(),
            ]),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 64,
          child: shrinkOffset < 40
              ? Text(
                  "Your \nThings",
                  style: TextStyle(
                      color: Colors.white
                          .withOpacity(contentOpacity(shrinkOffset) - 0.2),
                      fontSize: 32),
                )
              : const SizedBox.shrink(),
        ),
        Positioned(
          left: 16,
          bottom: 20,
          child: shrinkOffset < 100
              ? Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(
                      color: Colors.white12
                          .withOpacity(contentOpacity(shrinkOffset)),
                      fontSize: 10),
                )
              : const SizedBox.shrink(),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: shrinkOffset < 100
              ? Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        value: (donePercentage ?? 0) / 100,
                        strokeWidth: 2,
                        backgroundColor: Colors.white12,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${donePercentage?.toInt() ?? 0}% done",
                      style: TextStyle(
                          color: Colors.white12
                              .withOpacity(contentOpacity(shrinkOffset)),
                          fontSize: 10),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        Positioned(
          right: 16,
          bottom: 68,
          child: shrinkOffset < 100
              ? Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${personalCount ?? 0}".padLeft(2, '0'),
                            style: textStyle(shrinkOffset, fontSize: 20)),
                        Text("Personal", style: textStyle(shrinkOffset)),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${businessCount ?? 0}".padLeft(2, '0'),
                            style: textStyle(shrinkOffset, fontSize: 20)),
                        Text("Business", style: textStyle(shrinkOffset)),
                      ],
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  double contentOpacity(double shrinkOffset) {
    return 1.0 - (max(0.0, shrinkOffset) / maxExtent);
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent =>
      safeAreaHeight != null ? appBarHeight + safeAreaHeight! : appBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
