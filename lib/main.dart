

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import 'package:news_app/layout/news_layout/news_layout.dart';
import 'package:news_app/network/local/cash_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'layout/news_layout/cubit/cubit.dart';
import 'layout/news_layout/cubit/states.dart';
import 'shared/styles/bloc_observe.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   
  BlocOverrides.runZoned(
    () {
      // Use blocs...
       
    },
    blocObserver: MyBlocObserver(),
    
  );
   DioHelper.init();
   await  CashHelper.init();
   bool? isDark = CashHelper.getBoolean(key: 'isDark');
  runApp(MyApp( isDark) );




}

class MyApp extends StatelessWidget {
  
    bool? isDark;

  MyApp(this.isDark, );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience()..changeAppMode(fromShared: isDark),),
        //BlocProvider( create: (BuildContext context)=>NewsCubit()..changeAppMode(fromShared: isDark), ),
      ],
     
     
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: ((context, state) { }),
        builder: (context, state){
          return  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme:   const AppBarTheme(
             
              systemOverlayStyle:  SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark
              ),
              backgroundColor: Colors.white,
              elevation: 0,
               titleTextStyle: TextStyle(
                 color: Colors.black,
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),
               iconTheme: IconThemeData(
                 color: Colors.black
               ),
            ),
            floatingActionButtonTheme:   const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange
            ),
            bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              elevation: 20,
               backgroundColor: Colors.white
            ),
             textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black
              )
            )
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: HexColor('333739'),
             primarySwatch: Colors.deepOrange,
           
            appBarTheme:  AppBarTheme(
            
              systemOverlayStyle:  SystemUiOverlayStyle(
                statusBarColor:  HexColor('333739'),
                statusBarIconBrightness: Brightness.light
              ),
              backgroundColor:  HexColor('333739'),
              elevation: 0,
               titleTextStyle:  const TextStyle(
                 color: Colors.white,
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),
               iconTheme:  const IconThemeData(
                 color: Colors.white
               ),
            ),
            floatingActionButtonTheme:  const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange
            ),
            bottomNavigationBarTheme:  BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20,
              backgroundColor: HexColor('333739'),
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white
              )
            )
          ),
           themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          
          home:  const NewsLayout() ,
        );
        },
      ),
      
    );
    
  }
}
