import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ordering/models/totalModel.dart';
import 'package:ordering/services/totalValService.dart';

class Total extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  List<TotalValModel> totalValList;
  bool loading = true;
  getTotal() async {
    var url = "http://192.168.0.12/ordering/total.php";
    var response = await http.post(url);
    return response.body;
  }

  getTotalVal() async {
    totalValList = await TotalValService().getMenu();
    setState(() {
      loading = false;
    });
    print('ok');
    print("total : ${totalValList.length}");
  }

  @override
  void initState() {
    super.initState();
    getTotalVal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: totalValList.length,
              itemBuilder: (context, index) {
                TotalValModel cart = totalValList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ListTile(
                      title: Text(
                        cart.total,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
// getTotalVal() async {
//   totaVallList = await TotalValService().getMenu();

//   print("menu : ${totaVallList.length}");
// }

// getTotal() async {
//   var url = "http://192.168.0.12/ordering/total.php";
//   var response = await http.post(url);
//   return response.body;
// }
// body: FutureBuilder(
//     future: getTotal(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         print(snapshot.data);
//         return Card(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Total ',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       snapshot.data,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       } else {
//         return CircularProgressIndicator();
//       }
//     }),
// FutureBuilder(
//     future: getTotalVal(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         print(snapshot.data);
//         return Text(
//           snapshot.data,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         );
//       } else {
//         return CircularProgressIndicator();
//       }
//     }),
