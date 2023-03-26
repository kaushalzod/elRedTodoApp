import 'package:elredtodo/app/core/themes/theme.dart';
import 'package:elredtodo/app/core/utils/router.dart';
import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:elredtodo/app/modules/home/helper_widget/todo_listtile.dart';
import 'package:elredtodo/app/modules/todo/helper_widget/todo_textfield.dart';
import 'package:elredtodo/app/modules/todo/todoprovider.dart';
import 'package:elredtodo/app/widgets/masked_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  final Todo? todo;
  const TodoPage({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(todo: todo),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Iconsax.arrow_left,
                color: secondaryColor,
              ),
              onPressed: () => context.pop(),
            ),
            backgroundColor: primaryColor,
            elevation: 0,
            actions: [
              Consumer<TodoProvider>(builder: (context, value, child) {
                return PopupMenuButton(
                  icon: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(Iconsax.setting_5, color: secondaryColor),
                  ),
                  elevation: 3.2,
                  tooltip: 'This is tooltip',
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: "Delete",
                        child: Text("Delete"),
                      ),
                    ];
                  },
                );
              })
            ],
            title: Text(
              "${todo != null ? 'Edit' : 'Add'} new things",
              style: TextStyle(fontSize: 16, color: lightColor),
            ),
            centerTitle: true,
          ),
          body: Consumer<TodoProvider>(builder: (context, value, child) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    maskedIcon(
                      iconSelector(value.selectedType),
                      borderColor: Colors.white12,
                      customShader: [secondaryColor, Colors.pink],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                DropdownButton(
                  isExpanded: true,
                  value: value.selectedType,
                  itemHeight: 60,
                  iconDisabledColor: greyColor,
                  iconEnabledColor: greyColor,
                  selectedItemBuilder: (context) => value.dropDownItems
                      .map(
                        (e) => DropdownMenuItem(
                            value: e.toLowerCase(),
                            child: Text(e,
                                style: const TextStyle(color: Colors.white))),
                      )
                      .toList(),
                  hint: DropdownMenuItem(
                    value: null,
                    child: Text("Select Todo Type",
                        style: TextStyle(color: greyColor)),
                  ),
                  items: value.dropDownItems
                      .map(
                        (e) => DropdownMenuItem(
                            value: e.toLowerCase(), child: Text(e)),
                      )
                      .toList(),
                  onChanged: (v) {
                    value.setSelectedType = v;
                  },
                ),
                const SizedBox(height: 5),
                todoTextField(hint: "Todo Title", controller: value.title),
                const SizedBox(height: 15),
                todoTextField(
                    hint: "Description", controller: value.description),
                const SizedBox(height: 15),
                todoTextField(hint: "Date", controller: value.date),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shadowColor: Colors.black.withOpacity(0.5),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: Text(
                    "${todo != null ? 'EDIT' : 'ADD'} YOUR THINGS",
                    style: TextStyle(
                        color: lightColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
