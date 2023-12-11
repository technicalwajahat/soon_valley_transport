// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:soon_valley_transport/Model/bus_model.dart';
//
// import '../Data/bus_schedule_data.dart';
//
// class ViewBuses extends StatefulWidget {
//   const ViewBuses({Key? key}) : super(key: key);
//
//   @override
//   State<ViewBuses> createState() => _ViewBusesState();
// }
//
// class _ViewBusesState extends State<ViewBuses> {
//   List<BusModel> busesSchedule = getBusSchedule();
//   final searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const AutoSizeText(
//           "Buses Schedule",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const AutoSizeText(
//                   'Find your Travel Route',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
//                 ),
//                 const SizedBox(height: 6),
//                 const AutoSizeText(
//                   'Daily Schedule',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 18),
//                 TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search),
//                     hintText: "Search Bus, Station or City",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onChanged: searchBuses,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const ClampingScrollPhysics(),
//               itemCount: busesSchedule.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 0.0, horizontal: 26.0),
//                   child: BusCards(
//                     sourceStation: busesSchedule[index].sourceStation,
//                     destinationStation: busesSchedule[index].destinationStation,
//                     sourceCity: busesSchedule[index].sourceCity,
//                     destinationCity: busesSchedule[index].destinationCity,
//                     distance: busesSchedule[index].distance,
//                     route: busesSchedule[index].route,
//                     busName: busesSchedule[index].busName,
//                     totalSeat: busesSchedule[index].totalSeat,
//                     type: busesSchedule[index].type,
//                     startingTime: busesSchedule[index].startingTime,
//                     reachTime: busesSchedule[index].reachTime,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void searchBuses(String query) {
//     bool value;
//     final suggestions = getBusSchedule().where((element) {
//       final sourceCity = element.sourceCity.toString().toLowerCase();
//       final sourceDestination = element.sourceStation.toString().toLowerCase();
//       final destinationStation =
//       element.destinationStation.toString().toLowerCase();
//       final destinationCity = element.destinationCity.toString().toLowerCase();
//       final busName = element.busName.toString().toLowerCase();
//       final input = query.toLowerCase();
//
//       if (value = (sourceCity.contains(input)) ||
//           (sourceDestination.contains(input)) ||
//           (destinationCity.contains(input)) ||
//           (destinationStation.contains(input)) ||
//           (busName.contains(input))) {
//         return value;
//       }
//       return false;
//     }).toList();
//     setState(() => busesSchedule = suggestions);
//   }
// }
//
// class BusCards extends StatelessWidget {
//   final String sourceStation;
//   final String destinationStation;
//   final String sourceCity;
//   final String destinationCity;
//   final String distance;
//   final String route;
//   final String busName;
//   final String totalSeat;
//   final String type;
//   final String startingTime;
//   final String reachTime;
//
//   const BusCards({Key? key,
//     required this.sourceStation,
//     required this.destinationStation,
//     required this.sourceCity,
//     required this.destinationCity,
//     required this.distance,
//     required this.route,
//     required this.busName,
//     required this.totalSeat,
//     required this.type,
//     required this.startingTime,
//     required this.reachTime})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 6,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Container(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const AutoSizeText(
//                       'SOURCE',
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                     AutoSizeText(
//                       sourceStation,
//                       style: const TextStyle(
//                           fontSize: 14, fontWeight: FontWeight.bold),
//                     ),
//                     AutoSizeText(
//                       sourceCity,
//                       style: const TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Icon(Icons.double_arrow),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const AutoSizeText(
//                       'DESTINATION',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                     AutoSizeText(
//                       destinationStation,
//                       style: const TextStyle(
//                           fontSize: 14, fontWeight: FontWeight.bold),
//                     ),
//                     AutoSizeText(
//                       destinationCity,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.directions),
//                 const SizedBox(width: 5),
//                 Expanded(
//                   child: AutoSizeText(
//                     "$distance, $route",
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 5),
//             Row(
//               children: [
//                 const Icon(Icons.directions_bus),
//                 const SizedBox(width: 5),
//                 AutoSizeText("$busName, $totalSeat, $type")
//               ],
//             ),
//             const SizedBox(height: 5),
//             Row(
//               children: [
//                 const Icon(Icons.access_time_rounded),
//                 const SizedBox(width: 5),
//                 AutoSizeText(startingTime),
//                 const SizedBox(width: 16),
//                 const Icon(Icons.timelapse_rounded),
//                 const SizedBox(width: 5),
//                 AutoSizeText(reachTime),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
