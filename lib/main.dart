import 'package:contact_app/cubit/contact_cubit.dart';
import 'package:contact_app/routes/app_routes.dart';
import 'package:contact_app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext , Orientation , ScreenType ) {
      return BlocProvider(
        create: (_)=>ContactCubit()..createDataBase(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
           //   home:
           //    routes: {
           //      "/": (context)=> const HomePage(),
           //      "ContactPage":(context)=> const ContactPage()
           //    },
          onGenerateRoute: onGenerateRoute,
          initialRoute: AppRoutes.home,
        ),
      );},
    );
  }
}
