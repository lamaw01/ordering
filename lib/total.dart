import 'package:flutter/material.dart';
import 'package:ordering/models/totalModel.dart';
import 'package:ordering/services/totalValService.dart';

class Total extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  List<TotalValModel> totalValList;
  bool loading = true;

  getTotalVal() async {
    totalValList = await TotalValService().getMenu();
    setState(() {
      loading = false;
    });
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              cart.total,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
