import 'package:flutter/material.dart';

import '../Model/ac_fare_model.dart';

class UserAcBuses extends StatefulWidget {
  const UserAcBuses({Key? key}) : super(key: key);

  @override
  _UserAcBusesState createState() => _UserAcBusesState();
}

class _UserAcBusesState extends State<UserAcBuses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: myItemsAC.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 10,
              thickness: 0.6,
              indent: 20,
              endIndent: 20,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(myItemsAC[index].icon),
              title: Text(
                '${myItemsAC[index].to} - ${myItemsAC[index].from}',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: Text(
                myItemsAC[index].farePrice,
                style: const TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
