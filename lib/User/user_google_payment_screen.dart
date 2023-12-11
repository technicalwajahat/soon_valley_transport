import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '../Services/google_payment_config_service.dart';

class UserGooglePaymentScreen extends StatefulWidget {
  const UserGooglePaymentScreen({Key? key}) : super(key: key);

  @override
  _UserGooglePaymentScreenState createState() =>
      _UserGooglePaymentScreenState();
}

class _UserGooglePaymentScreenState extends State<UserGooglePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Online Pay",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GooglePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultGooglePay),
            paymentItems: const [
              PaymentItem(
                label: 'Total',
                amount: "0.00",
                status: PaymentItemStatus.final_price,
              )
            ],
            type: GooglePayButtonType.book,
            width: double.infinity,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
            onPaymentResult: (Map<String, dynamic> result) {
              print(result);
            },
          ),
        ),
      ),
    );
  }
}
