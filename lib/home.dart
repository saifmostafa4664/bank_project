import 'package:bank_project/Withdraw.dart';
import 'package:bank_project/deposit.dart';
import 'package:bank_project/sqlconnction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  late final Map<String, dynamic> userData;

  HomePage({Key? key, required this.userData}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = Mysql();
  var mail;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Welcome.. ${widget.userData['F_Nmae']} ${widget.userData['L_Name']}'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: 225,
                height: 225,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 10,
                    color: Colors.blue,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  gradient: LinearGradient(
                    // تغيير لون الخلفية
                    colors: [Colors.white, Colors.grey],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    ' ${widget.userData['Amount']}\$',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Withdraw(userData: widget.userData),
                      ),
                    );
                  },
                  child: Text("Deposit"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(226, 177, 16, 1),
                    onPrimary: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.3,
                      vertical: 20,
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              deposit(userData: widget.userData),
                        ));
                  },
                  child: Text("Withdraw"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(70, 190, 86, 1),
                    onPrimary: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.3,
                      vertical: 20,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
