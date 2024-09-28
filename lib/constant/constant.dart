import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var  nameController = TextEditingController();
var  phoneController = TextEditingController();
CountryCode myCountry = CountryCode(name:"EG" , dialCode: "+20");
var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();