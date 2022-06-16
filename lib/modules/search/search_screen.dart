

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';
import 'package:news_app/shared/component/components.dart';

class SearchScreen extends StatelessWidget {
 
  var searchContreller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: ((context, state) { }),
      builder: (context,state){
       var list = NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                controller: searchContreller, 
                type: TextInputType.text, 
                onChanged: (value)
                {
                   NewsCubit.get(context).getSearch(value);
                },
                lable: 'search', 
                prefix: Icons.search
                ),
            ),
            Expanded(child: articleBuilder(list, context ,isSearch: true))
          ]
          ),
      );
      },
       
    );
  }
}