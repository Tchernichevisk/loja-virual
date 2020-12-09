import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // providers
    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
            create: (_) => UserManager(),
          lazy: false,
        ),

        ChangeNotifierProvider(
            create: (_) => ProductManager(),
          lazy: false,
        )

      ],

      child: MaterialApp(
        title: 'Loja do Tchernichevisk',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor:const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

       initialRoute: '/base',
       onGenerateRoute: (settings){
      switch (settings.name){

      case '/login':
        return MaterialPageRoute(
            builder: (_)=>LoginScreen()
        );



      case '/signup':
        return MaterialPageRoute(
          builder: (_)=>SignUpScreen()
        );

         case '/base':
      default:
        return MaterialPageRoute(
          builder: (_) =>BaseScreen()
      );
      }
       },
      ),
    );
  }
}

