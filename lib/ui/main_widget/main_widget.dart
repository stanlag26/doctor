import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../api/auth/auth.dart';
import '../../const/const.dart';
import 'main_widget_model.dart';

class MainProviderWidget extends StatelessWidget {
  const MainProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MainWidgetModel(), child: const MainWidget());
  }
}


class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainWidgetModel>();
    return  Scaffold(
      appBar: AppBar(
        title: Text('Лекарь', style: MyTextStyle.textStyle25,),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                MyAuth.signOut();
                Navigator.pushNamed(context, '/sign-in');
              },
              icon: Icon(
                FontAwesomeIcons.arrowRightFromBracket,
              )),
        ],
      ),
      body: model.widgetOptions.elementAt(model.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.pills),
          label: 'Мой курс',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.prescriptionBottleMedical),
          label: 'Рецепт',
        ),
      ],
        currentIndex: model.selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: model.onItemTapped,

      ),




    );
  }
}
