// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
class Items {  
  const Items({required this.title, required this.icon});  
  final String title;  
  final IconData icon;  
}  
  
const List<Items> choices = const <Items>[  
  const Items(title: 'Home', icon: Icons.home),  
  const Items(title: 'Contact', icon: Icons.contacts),  
 
];  