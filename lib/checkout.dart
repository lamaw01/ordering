import 'package:flutter/material.dart';
import 'package:ordering/colors.dart';
import 'package:ordering/models/checkoutModel.dart';
import 'package:ordering/services/checkoutService.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<CheckoutModel> checkOutList;
  bool loading = true;

  getCheckout() async {
    checkOutList = await CheckoutService().getCheckout();
    setState(() {
      loading = false;
    });
    print("checkout : ${checkOutList.length}");
  }

  @override
  void initState() {
    super.initState();
    getCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: canvasColor,
        centerTitle: true,
        title: Text(
          'Order Slip',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: titleColor,
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    itemCount: checkOutList.length,
                    itemBuilder: (context, index) {
                      CheckoutModel checkout = checkOutList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Order# ' + checkout.orderid,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Total : ' + checkout.summary,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
