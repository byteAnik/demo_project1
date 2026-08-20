
import 'package:demo_project1/provider/carosul_provider.dart';
import 'package:demo_project1/provider/customer_provider.dart';
import 'package:demo_project1/provider/forget_password_provider.dart';
import 'package:demo_project1/provider/profile_provider.dart';
import 'package:demo_project1/provider/singnup_provider.dart';
import 'package:provider/provider.dart';


var providers = [
  ChangeNotifierProvider<ForgetPasswordProvider>(
    create: ((context) => ForgetPasswordProvider()),
  ),

  ChangeNotifierProvider<SignupProvider>(
    create: ((context) => SignupProvider()),
  ),

  ChangeNotifierProvider<ProfileProvider>(
    create: ((context) => ProfileProvider()),
  ),

  ChangeNotifierProvider<CarosulProvider>(
    create: ((context) => CarosulProvider()),
  ),

  ChangeNotifierProvider<CustomerProvider>(
    create: ((context) => CustomerProvider()),
  ),
];
