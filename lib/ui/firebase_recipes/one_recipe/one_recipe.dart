

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'one_recipes_model.dart';

class OneRecipesProviderWidget extends StatelessWidget {
  const OneRecipesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => OneRecipesModel(),
        child: const OneRecipes());
  }
}


class OneRecipes extends StatelessWidget {
  const OneRecipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
