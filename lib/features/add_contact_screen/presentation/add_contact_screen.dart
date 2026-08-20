import 'dart:convert';

import 'package:demo_project1/common_wigdets/common_button.dart';
import 'package:demo_project1/common_wigdets/common_textform_flied.dart';
import 'package:demo_project1/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController=TextEditingController();
  final phoneController=TextEditingController();
  
  Future<void> saveContact() async {
    final name=nameController.text.trim();
    final phone=phoneController.text.trim();

    if(name.isEmpty || phone.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter name and phone number')
        ),
      );
      return;
    }
      final prefs = await SharedPreferences.getInstance();
    final String? oldData = prefs.getString('contacts');
    List<Map<String,String>>contacts=[];
    if(oldData !=null){
      final List<dynamic>decoded = jsonDecode(oldData);
      contacts=decoded.map((item)=>Map<String,String>.from(item)).toList();
    }
    contacts.add({
      'name':name,
      'phone':phone,
    });
    await prefs.setString('contacts', jsonEncode(contacts),);
    if(!mounted)return;
    Navigator.pop(context);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: UIHelper.kDefaulutPadding(),
          
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(16.h),
                CommonTextFormField(
                  label: 'Name', 
                  hintText: 'Enter your name',
                  controller: nameController,
                  ),
                  UIHelper.verticalSpace(16.h),
                  CommonTextFormField(
                  label: 'Phone', 
                  hintText: 'Enter your phone number',
                  controller: phoneController,
                  ),
                  UIHelper.verticalSpace(24.h),
                  CommonButton(
                    text: 'Save Contact', 
                    onPressed: (){
                      saveContact();
                    }
                    ),
              ],
            ),
          ),
      ),
    );
  }
}
