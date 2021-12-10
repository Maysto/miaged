import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../profile_page/profile_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF482B92),
        automaticallyImplyLeading: false,
        title: Text(
          'Miaged - Home Page',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: FaIcon(
              FontAwesomeIcons.addressBook,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePageWidget(),
                ),
              );
            },
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFF2B3161),
      body: SafeArea(
        child: StreamBuilder<List<ItemsRecord>>(
          stream: queryItemsRecord(
            queryBuilder: (itemsRecord) =>
                itemsRecord.orderBy('time_posted', descending: true),
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.primaryColor,
                  ),
                ),
              );
            }
            List<ItemsRecord> listViewItemsRecordList = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: listViewItemsRecordList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewItemsRecord =
                    listViewItemsRecordList[listViewIndex];
                return StreamBuilder<UsersRecord>(
                  stream: UsersRecord.getDocument(listViewItemsRecord.user),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                      );
                    }
                    final cardUsersRecord = snapshot.data;
                    return Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.network(
                            listViewItemsRecord.photo,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Posted By: ',
                                style: FlutterFlowTheme.bodyText1,
                              ),
                              Text(
                                cardUsersRecord.displayName,
                                style: FlutterFlowTheme.bodyText1,
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Category : ',
                                style: FlutterFlowTheme.bodyText1,
                              ),
                              Text(
                                listViewItemsRecord.category,
                                style: FlutterFlowTheme.bodyText1,
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Gender : ',
                                style: FlutterFlowTheme.bodyText1,
                              ),
                              Text(
                                listViewItemsRecord.gender,
                                style: FlutterFlowTheme.bodyText1,
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Price : ',
                                style: FlutterFlowTheme.bodyText1,
                              ),
                              Text(
                                formatNumber(
                                  listViewItemsRecord.price,
                                  formatType: FormatType.decimal,
                                  decimalType: DecimalType.commaDecimal,
                                  currency: '€',
                                ),
                                style: FlutterFlowTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
