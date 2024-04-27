import 'package:flutter/material.dart';
import 'package:soon_valley_transport/Model/non_ac_fare_model.dart';

class UserNonAcBuses extends StatefulWidget {
  const UserNonAcBuses({Key? key}) : super(key: key);

  @override
  State<UserNonAcBuses> createState() => _UserNonAcBusesState();
}

class _UserNonAcBusesState extends State<UserNonAcBuses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: myItemsNonAC.length,
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
              leading: Icon(myItemsNonAC[index].icon),
              title: Text(
                '${myItemsNonAC[index].to} - ${myItemsNonAC[index].from}',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: Text(
                myItemsNonAC[index].farePrice,
                style: const TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
