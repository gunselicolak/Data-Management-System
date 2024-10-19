import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user_provider.dart';
import 'pages/login_page.dart';
import 'pages/data_entry_page.dart';
import 'pages/responsible_assignment_page.dart'; // Kendi sayfana göre ekle

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/data_entry_page': (context) => DataEntryPage(),
        '/responsible_assignment_page': (context) => ResponsibleAssignmentPage(), // Kendi sayfana göre ekle
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
// import 'package:flutter/services.dart';
// import 'package:my_web_project/test_model.dart'; // TestModel sınıfını import edin.



// void main() {
//   runApp(
//     const MaterialApp(
//       home: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<TestModel> studentsInfoList = [];
//   List<TableRow> tableRowsList = [];
//   bool isLoading = false;
//   final _connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
//   final _nameController = TextEditingController();
//   final _weightController = TextEditingController();

//   @override
//   void initState() {
//     getStudentsTableData();
//     super.initState();
//   }

//   void getStudentsTableData() {
//   setState(() {
//     isLoading = true;
//   });
//   studentsInfoList.clear();
//   _connectToSqlServerDirectlyPlugin
//       .initializeConnection(
//     '192.168.183.1', //Server
//     'DataManagement',  //Database Name
//     '', 
//     '',
//     instance: 'node',
//   )
  
//       .then((value) {
//     if (value) {
//       try {
//         _connectToSqlServerDirectlyPlugin
//             .getRowsOfQueryResult("SELECT * FROM dbo.DataCategories")
//             .then((value) {
//           if (value.runtimeType == String) {
//             onError(value.toString());
//           } else {
//             List<Map<String, dynamic>> tempResult =
//                 value.cast<Map<String, dynamic>>();
//             for (var element in tempResult) {
//               studentsInfoList.add(
//                 TestModel(
//                   kategori: element['KATEGORİ'],
//                   grup: element['GRUP'],
//                   degerTuru: element['DEĞER_TÜRÜ'],
//                   birim: element['BİRİM'],
//                   veriPeriyodu: element['VERİ_PERİYODU'],
//                 ),
//               );
//             }
//           }
//         });
//       } catch (error) {
//         print('Error fetching data: $error');
//         onError(error.toString());
//       }
//     } else {
//       onError('Failed to Connect!');
//     }
//   });
// }


//   void onError(String message) {
//     setState(() {
//       isLoading = false;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 6),
//         padding: const EdgeInsets.all(8.0),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Text(
//                 message,
//                 style: const TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Connect To Sql Server Directly'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         onPressed: () {
//           _nameController.clear();
//           _weightController.clear();
//           final formKey = GlobalKey<FormState>();
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 backgroundColor: Colors.white,
//                 elevation: 4.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 contentPadding: const EdgeInsets.all(16.0),
//                 insetPadding: const EdgeInsets.symmetric(
//                   horizontal: 40,
//                 ),
//                 content: SizedBox(
//                   width: MediaQuery.of(context).size.width - 40,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Form(
//                         key: formKey,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Expanded(
//                               flex: 1,
//                               child: Text(
//                                 "Name",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 height: 40,
//                                 padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.blue.withOpacity(0.4),
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: const Offset(
//                                           0, 0), // changes position of shadow
//                                     ),
//                                   ],
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: Center(
//                                   child: TextFormField(
//                                     validator: (String? value) {
//                                       if (value != null && value.trim() == "") {
//                                         return "Name can't be empty!";
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       contentPadding: EdgeInsets.zero,
//                                     ),
//                                     textDirection: TextDirection.ltr,
//                                     textAlign: TextAlign.center,
//                                     textInputAction: TextInputAction.done,
//                                     controller: _nameController,
//                                     style: const TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Expanded(
//                             flex: 1,
//                             child: Text(
//                               "Weight",
//                               style: TextStyle(
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Container(
//                               height: 40,
//                               padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.blue.withOpacity(0.4),
//                                     spreadRadius: 1,
//                                     blurRadius: 1,
//                                     offset: const Offset(
//                                         0, 0), // changes position of shadow
//                                   ),
//                                 ],
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: Center(
//                                 child: TextFormField(
//                                   keyboardType: TextInputType.number,
//                                   textInputAction: TextInputAction.done,
//                                   controller: _weightController,
//                                   inputFormatters: [
//                                     FilteringTextInputFormatter.allow(
//                                       RegExp(r'^[0-9]+(.)?([0-9]+)?'),
//                                     ),
//                                   ],
//                                   decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.zero,
//                                   ),
//                                   textDirection: TextDirection.ltr,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             borderRadius: BorderRadius.circular(15),
//                             onTap: () {
//                               if (formKey.currentState!.validate()) {
//                                 Navigator.pop(context);
//                               }
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//                               width: MediaQuery.of(context).size.width / 3,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.black,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 textDirection: TextDirection.rtl,
//                                 children: const [
//                                   Text(
//                                     "Register",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             borderRadius: BorderRadius.circular(15),
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//                               width: MediaQuery.of(context).size.width / 3,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.grey,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 textDirection: TextDirection.rtl,
//                                 children: const [
//                                   Text(
//                                     "Cancel",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       "Students  Sample Table",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               (!isLoading && studentsInfoList.isNotEmpty)
//                   ? Table(
//                       border: TableBorder.all(
//                         color: Colors.black,
//                         width: 1.0,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       columnWidths: const {
//                         0: FlexColumnWidth(0.3),
//                         1: FlexColumnWidth(0.4),
//                         2: FlexColumnWidth(0.3)
//                       },
//                       defaultVerticalAlignment:
//                           TableCellVerticalAlignment.middle,
//                       children: tableRowsList,
//                     )
//                   : (isLoading)
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             CircularProgressIndicator(
//                               color: Colors.black,
//                             ),
//                           ],
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text('This Table is Empty!'),
//                           ],
//                         ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }