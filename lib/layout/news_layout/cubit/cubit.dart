
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/local/cash_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex =0;
  List<BottomNavigationBarItem> bottomItem =[
    const BottomNavigationBarItem(
      icon:Icon(Icons.business) ,
      label: 'Business',
      ),
      const BottomNavigationBarItem(
      icon:const Icon(Icons.sports) ,
      label: 'Sports',
      ),
      const BottomNavigationBarItem(
      icon:Icon(Icons.science) ,
      label: 'Science',
      ),
      
  ];

  List<Widget> screens =[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
   
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index==1)
    getSports();
     if(index==2)
    getScience();
    emit( NewsBottomNavState());
  }
  
  List<dynamic> business =[];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', 
                query: {
                  'Country':'eg',
                  'Category':'business',
                  'apiKey':'d5ec87b167e74fb2a8f7687eb0b0d798'
                  }
                  ).then((value) {
                    //print(value?.data['articles'][0]['title']);
                  business =value?.data['articles'];
                  print(business[0]['title']);
                  emit(NewsGetBusinessSuccessState());
                  }).catchError((error){print(error.toString());
                  emit(NewsGetBusinessErrorState(error.toString()));
                  });
  }

  List<dynamic> sports =[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length==0)
    {
     DioHelper.getData(url: 'v2/top-headlines', 
                query: {
                  'Country':'eg',
                  'Category':'sports',
                  'apiKey':'d5ec87b167e74fb2a8f7687eb0b0d798'
                  }
                  ).then((value) {
                    //print(value?.data['articles'][0]['title']);
                  sports =value?.data['articles'];
                  print(sports[0]['title']);
                  emit(NewsGetSportsSuccessState());
                  }).catchError((error){print(error.toString());
                  emit(NewsGetSportsErrorState(error.toString()));
                  });
  }else{ emit(NewsGetSportsSuccessState());}
    }
      


  List<dynamic> science =[];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length==0)
    {
       DioHelper.getData(url: 'v2/top-headlines', 
                query: {
                  'Country':'eg',
                  'Category':'science',
                  'apiKey':'d5ec87b167e74fb2a8f7687eb0b0d798'
                  }
                  ).then((value) {
                    //print(value?.data['articles'][0]['title']);
                  science =value?.data['articles'];
                  print(science[0]['title']);
                  emit(NewsGetScienceSuccessState());
                  }).catchError((error){print(error.toString());
                  emit(NewsGetScienceErrorState(error.toString()));
                  });
    }else{ emit(NewsGetScienceSuccessState());}
     
  }


   bool isDark = true;

 void changeAppMode({bool? fromShared})
 {
   if(fromShared != null)
   {
     isDark = fromShared;
     emit(AppChangeModeState());
   }
   
   else
   {
    isDark = !isDark;

  CashHelper.putBoolean(key: 'isDark',value: isDark).then((value)
  {
   
   emit(AppChangeModeState());
  });
  print('eman${isDark}');
   }
  
 
  
 }


 List<dynamic> search =[];
  void getSearch(String value)
  {

    emit(NewsGetScienceLoadingState());
   
       DioHelper.getData(url: 'v2/everything', 
                query: {
                  
                  'q':'$value',
                  'apiKey':'d5ec87b167e74fb2a8f7687eb0b0d798'
                  }
                  ).then((value) {
                    //print(value?.data['articles'][0]['title']);
                 search =value?.data['articles'];
                  print(search[0]['title']);
                  emit(NewsGetSearchSuccessState());
                  }).catchError((error){print(error.toString());
                  emit(NewsGetSearchErrorState(error.toString()));
                  });   
  }
 
}

