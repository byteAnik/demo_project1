import 'dart:convert';

import 'package:demo_project1/features/add_contact_screen/presentation/add_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Map<String,String>>contacts=[];
  @override
  void initState(){
    super.initState();
    localContacts();
  }
  Future<void> localContacts()async{
    final prefs = await SharedPreferences.getInstance();
    final String? oldData = prefs.getString('contacts');
    List<Map<String,String>>loadedContacts=[];
    if(oldData !=null){
      final List<dynamic>decoded = jsonDecode(oldData);
      loadedContacts=decoded.map((item)=>Map<String,String>.from(item)).toList();
    }
    if(!mounted)return;
    setState(() {
      contacts=loadedContacts;
    });
  }
  Future<void> deleteContact(int index)async{
    final prefs = await SharedPreferences.getInstance();
    contacts.removeAt(index);
    await prefs.setString('contacts', jsonEncode(contacts),);
    if(!mounted)return;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Contacts',
      style: GoogleFonts.anekBangla(
        fontWeight: FontWeight.w700,
        fontSize: 22.sp,
        color: Colors.black,
      ),),),
     
      body: contacts.isEmpty ? Center(
        child: Text('NO contact yet'),
      )
      :ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact =contacts[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person)
                
              ),
              title: Text(
                contact['name']??'',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
                subtitle: Text(contact['phone']??'',
                
            ),
            trailing: IconButton(onPressed: (){
              deleteContact(index);
            }, icon:Icon(Icons.delete)),
          ),
          );
        },
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await Get.to(()=>AddContactScreen());
        localContacts();
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
