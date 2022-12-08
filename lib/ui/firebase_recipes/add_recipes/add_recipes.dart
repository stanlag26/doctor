import 'package:doctor/my_widgets/my_button.dart';
import 'package:doctor/my_widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../const/const.dart';
import 'add_recipes_model.dart';


class AddRecipesProviderWidget extends StatelessWidget {
  const AddRecipesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddRecipesModel(), child: AddRecipes());
  }
}

class AddRecipes extends StatelessWidget {
  AddRecipes({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountOfDaysController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddRecipesModel>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Лекарь',
            style: MyTextStyle.textStyle25,
          ),
          centerTitle: true),
      body: SafeArea(
        child: ListView(
          children: [
            MyTextField(
                hintTextField: 'Название лекарства',
                controller: nameController),
            MyTextField(
              hintTextField: 'Описание лекарства',
              controller: descriptionController,
              maxLine: 5,
            ),
            MyTextField(
              hintTextField: 'Количество дней курса',
              controller: amountOfDaysController,
              textType: TextInputType.number,
            ),
            SizedBox(
              height: 15,
            ),
            MyButton(
                myText: Text('Добавить фото лекарства'),
                onPress: () {
                  model.myShowAdaptiveActionSheet(context);
                }),
            SizedBox(
              height: 15,
            ),
            MyButton(
                myText: Text('Добавить время приема лекарств'),
                onPress: () {
                  model.addTime(context);
                }),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: model.interval.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            ListTile(
                              leading:Icon(FontAwesomeIcons.clock),
                              title: Text('${model.interval[index].hour.toString()}:${model.interval[index].minute.toString()}'),
                              trailing: IconButton(
                                onPressed: () {
                                  model.delTime(index);
                                },
                                icon: Icon(FontAwesomeIcons.trash, color: Colors.red,),)
                            ),
                          ],
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
