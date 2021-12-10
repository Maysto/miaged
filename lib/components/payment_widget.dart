import '../flutter_flow/flutter_flow_credit_card_form.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../succes_buy/succes_buy_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({
    Key key,
    this.item,
  }) : super(key: key);

  final DocumentReference item;

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final creditCardFormKey = GlobalKey<FormState>();
  CreditCardModel creditCardInfo = emptyCreditCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF262D34),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 20, 12, 0),
            child: FlutterFlowCreditCardForm(
              formKey: creditCardFormKey,
              creditCardModel: creditCardInfo,
              obscureNumber: true,
              obscureCvv: false,
              spacing: 10,
              textStyle: GoogleFonts.getFont(
                'Lexend Deca',
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              inputDecoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF9E9E9E),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF9E9E9E),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                await widget.item.delete();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccesBuyWidget(),
                  ),
                );
              },
              text: 'ACHETER',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: Color(0xFF5D1CB0),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
