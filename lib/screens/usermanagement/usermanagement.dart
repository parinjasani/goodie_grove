import 'package:finalyeraproject/Firebase/firebase_singleton.dart';
import 'package:finalyeraproject/models/Employee.dart';
import 'package:flutter/material.dart';
class UsermanagementScreen extends StatefulWidget {
  const UsermanagementScreen({super.key});

  @override
  State<UsermanagementScreen> createState() => _UsermanagementScreenState();
}

class _UsermanagementScreenState extends State<UsermanagementScreen> {
  FirebaseSingleton service=FirebaseSingleton();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [const Text(
          "USERS CREDIT",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
          SizedBox(
            height: 15,
          ),
          StreamBuilder(builder: (context, snapshot) {
            if(snapshot.hasData){
              var emplist=snapshot.data!;
              return Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: ListTile(

                                  subtitle: Text(
                                    emplist[index].email!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                  title: Text(
                                    emplist[index].username!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  trailing: Container(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                int x= emplist[index].credit!;
                                                x-=50;
                                                service.updateEmployeeCreditByEmail(emplist[index].email!,x);
                                              });
                                            },
                                            color: Colors.white,
                                            icon: Icon(Icons.remove)),
                                        Text(
                                          emplist[index].credit!.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                int x= emplist[index].credit!;
                                                x+=50;
                                                service.updateEmployeeCreditByEmail(emplist[index].email!,x);
                                              });
                                            },
                                            color: Colors.white,
                                            icon: Icon(Icons.add)),


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                    itemCount: emplist.length),
              );
            }else if (snapshot.hasError) {
              return Center(child: Text("Something went wrong ${snapshot.error.toString()} ${snapshot.data}"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },stream: service.getUserlist(),),
        ],
      ),
    );

  }
}
