import 'package:elredtodo/app/core/themes/theme.dart';
import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:elredtodo/app/widgets/masked_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:intl/intl.dart';

Widget todoListTile(Todo todoModel,
    {void Function()? onTileTap,
    void Function()? onIconTap,
    bool completed = false}) {
  return GestureDetector(
    onTap: onTileTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onIconTap,
            child: maskedIcon(
              completed ? Icons.check_rounded : iconSelector(todoModel.type),
              backgroundColor: completed ? primaryColor : Colors.white,
              shaderWhite: completed,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todoModel.title ?? "NA",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: completed ? Colors.grey : null),
                ),
                Text(
                  todoModel.description ?? "NA",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: completed ? Colors.grey : null,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              todoModel.date?.replaceAll(',', '\n') ?? "NA",
              style: TextStyle(
                fontSize: 10,
                color: completed ? Colors.grey : null,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}

IconData iconSelector(String? type) {
  if (type?.toLowerCase() == 'business') {
    return Iconsax.status_up;
  } else if (type?.toLowerCase() == "personal") {
    return Iconsax.emoji_happy;
  } else if (type?.toLowerCase() == "design") {
    return Iconsax.designtools;
  } else if (type?.toLowerCase() == "study") {
    return Iconsax.book;
  } else if (type?.toLowerCase() == "music") {
    return Iconsax.music;
  } else {
    return Iconsax.heart;
  }
}

todoSectionTitle(String title, {int? totalCount = 0}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20)
          .add(const EdgeInsets.only(top: 20)),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: greyColor),
          ),
          const SizedBox(width: 10),
          if (totalCount != null && totalCount != 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: greyColor),
              child: Text(
                totalCount.toString(),
                style: TextStyle(fontSize: 10, color: lightColor),
              ),
            )
        ],
      ),
    ),
  );
}
