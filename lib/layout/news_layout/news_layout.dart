import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';
import 'package:news_app/shared/component/components.dart';

import '../../modules/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext  context)=>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context, state) => {},
        builder:(context, state)  {
          var cubit = NewsCubit.get(context);

          return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),

            actions: [
              IconButton(onPressed: (){ 
                navigateTo(context, SearchScreen());
               },
              icon: const Icon(Icons.search)
              ),
               IconButton(onPressed: (){ 
                 print('${cubit.isDark}');
                  cubit.changeAppMode();
                
                
                 
                },
              icon:const Icon(Icons.brightness_4_outlined)
              ),
            ],
          
          ),

         
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItem,
        
          ),
        );
        },
      
      ),
    );
  }
}
