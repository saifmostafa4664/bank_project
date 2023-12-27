import 'dart:async';
import 'package:bank_project/sqlconnction.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> arr = [];
  late StreamController _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();
    _getselect();
  }

  void _getselect() {
    var db = Mysql();
    db.getConnection().then((connn) {
      var sql = 'SELECT * FROM `users`';
      connn.query(sql).then((reset) {
        setState(() {
          for (var row in reset) {
            arr.add({
              'ID': row['ID'],
              'F_Nmae': row['F_Nmae'],
              'Amount': row['Amount'],
              'L_Name': row['L_Name']
            });
          }
          _streamController.add(null);
        });
      });
    });
  }

  void _getdelet(var id) {
    var db = Mysql();
    db.getConnection().then((connnn) {
      String sql = 'DELETE FROM `users` WHERE `users`.`ID` = ?';
      connnn.query(sql, [id]).then((_) {
        _streamController.add(null);
      });
    });
  }

  void _addNewUser() {}

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_streamController.hasListener) {
      _streamController = StreamController.broadcast();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Page',
            style: TextStyle(fontSize: 40),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: StreamBuilder(
          stream: _streamController.stream,
          builder: (BuildContext context, snapshot) {
            return ListView.builder(
              itemCount: arr.length,
              itemBuilder: (BuildContext context, int index) {
                final user = arr[index];
                return Dismissible(
                  key: Key(user['ID'].toString()),
                  onDismissed: (direction) {
                    setState(() {
                      arr.removeAt(index);
                    });
                    _getdelet(user['ID']);
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name : ${user['F_Nmae']} ${user['L_Name']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Amount : ${user['Amount']}',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                arr.removeAt(index);
                              });
                              _getdelet(user['ID']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewUser,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminPage(),
  ));
}
