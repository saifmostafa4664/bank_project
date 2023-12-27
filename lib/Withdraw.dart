import 'package:bank_project/singe_in.dart';
import 'package:bank_project/sqlconnction.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  final Map<String, dynamic> userData;

  Withdraw({Key? key, required this.userData}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  var db = Mysql();
  void _getw(String am, int idw) {
    db.getConnection().then((conn) {
      String sql =
          'UPDATE `users` SET `Amount` = Amount + ? WHERE `users`.`ID` = ?';
      conn.query(sql, [am, idw]).then((results) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Loginscreen(),
          ),
        );
      }).catchError((error) {});
    });
  }

  var amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome.',
              style: TextStyle(fontSize: 46),
            ),
            SizedBox(
              height: 40,
            ),
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
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: (value) {
                  amount = value;
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.monetization_on),
                  hintText: 'Enter Your amount',
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
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  String i = amount;
                  int d = widget.userData['ID'];
                  _getw(i, d);
                },
                child: Text('Deposit'),
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
      ),
    );
  }
}
