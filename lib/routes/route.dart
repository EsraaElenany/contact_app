import 'package:contact_app/screens/home_page.dart';
import 'package:flutter/material.dart';

import '../screens/contact_page.dart';
import 'app_routes.dart';

Route<dynamic>?  onGenerateRoute(RouteSettings routeSettings){

  switch(routeSettings.name){
     case AppRoutes.home :return  MaterialPageRoute(builder:(_)=>  HomePage() ,
        settings: routeSettings );
     case AppRoutes.contactPage : return MaterialPageRoute(builder:(_)=> const ContactPage() ,
        settings: routeSettings );
    default: return null;
  }

}