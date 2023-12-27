import 'package:bank_project/adminpage.dart';
import 'package:bank_project/home.dart';
import 'package:bank_project/sqlconnction.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var db = Mysql();
  var mail;

  void moveToHomePageWithData(
      BuildContext context, Map<String, dynamic> fetchedUserData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(userData: fetchedUserData),
      ),
    );
  }

  void _getco(String username, String password) {
    db.getConnection().then((conn) {
      String sql = 'SELECT * FROM `users` WHERE ID = ? AND password = ?';
      conn.query(sql, [username, password]).then((results) {
        if (results.isNotEmpty) {
          Map<String, dynamic> fetchedUserData = {
            'ID': results.first['ID'],
            'F_Nmae': results.first['F_Nmae'],
            'L_Name': results.first['L_Name'],
            'Password': results.first['Password'],
            'Amount': results.first['Amount'],
          };

          moveToHomePageWithData(context, fetchedUserData);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('خطأ في تسجيل الدخول'),
                content: Text('اسم المستخدم أو كلمة المرور غير صحيحة.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('موافق'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  String username1 = '';
  String password1 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome.',
            style: TextStyle(fontSize: 46),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              onChanged: (value) {
                username1 = value;
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.perm_identity_outlined),
                hintText: 'Enter Your ID',
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Color(0xFFE5E5E5),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 19.0),
              ),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              onChanged: (value) {
                password1 = value;
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.password),
                hintText: 'Enter Your Password',
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Color(0xFFE5E5E5),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 19.0),
              ),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                String username = username1;
                String password = password1;
                if (username == 'admin' && password == 'admin') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPage(),
                    ),
                  );
                } else {
                  _getco(username, password);
                }
              },
              child: Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(70, 190, 86, 1),
                  onPrimary: Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.3,
                    vertical: 20,
                  ))),
        ],
      ),
    ));
  }
}
