import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/models/cake_shop.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CakeShopDetailUi extends StatefulWidget {
  //สร้างตัวแปรรับข้อมูลร้านที่จะส่งมาจากหน้า CakeShopListUi`
  CakeShop? cakeShopDetail;

  //เอาตัวแปรที่สร้างไว้มารับข้อมูลที่ส่งมาจากหน้า CakeShopListUi`
  CakeShopDetailUi({super.key, this.cakeShopDetail});

  @override
  State<CakeShopDetailUi> createState() => _CakeShopDetailUiState();
}

class _CakeShopDetailUiState extends State<CakeShopDetailUi> {
  //เมธอดโทร
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //เมธอดเปิดเว็บ
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  MapController? mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 74, 74),
        title: Text(
          widget.cakeShopDetail!.name!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(45.0),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    //'assets/images/' + widget.cakeShopDetail!.image1!,
                    'assets/images/${widget.cakeShopDetail!.image1!}',
                    width: 120.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        //'assets/images/' + widget.cakeShopDetail!.image1!,
                        'assets/images/${widget.cakeShopDetail!.image2!}',
                        width: 120.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        //'assets/images/' + widget.cakeShopDetail!.image1!,
                        'assets/images/${widget.cakeShopDetail!.image3!}',
                        width: 120.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.shop,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.name!,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.locationPin,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.address!,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _makePhoneCall(widget.cakeShopDetail!.phone!);
                          },
                          leading: Icon(
                            FontAwesomeIcons.phone,
                            color: Colors.green,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.phone!,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _launchInBrowser(
                                Uri.parse(widget.cakeShopDetail!.website!));
                          },
                          leading: Icon(
                            FontAwesomeIcons.globe,
                            color: Colors.amber,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.website!,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _launchInBrowser(
                                Uri.parse(widget.cakeShopDetail!.facebook!));
                          },
                          leading: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blueAccent,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.facebook!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  child: FlutterMap(
                    mapController: mapController,
                    //กำหนดตำแหน่งของแผนที่
                    options: MapOptions(
                      initialCenter: LatLng(
                        double.parse(widget.cakeShopDetail!.latitude!),
                        double.parse(widget.cakeShopDetail!.longitude!),
                      ),
                      initialZoom: 15.0,
                    ),
                    //วาดแผนที่
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                    'https://openstreetmap.org/copyright'),
                              );
                            },
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              double.parse(widget.cakeShopDetail!.latitude!),
                              double.parse(widget.cakeShopDetail!.longitude!),
                            ),
                            child: InkWell(
                              onTap: () {
                                //เปิด Google Maps ด้วยพิกัดที่กำหนด
                                String googleMapsUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${widget.cakeShopDetail!.latitude},${widget.cakeShopDetail!.longitude}';
                                _launchInBrowser(Uri.parse(googleMapsUrl));
                              },
                              child: Icon(
                                // FontAwesomeIcons.locationArrow,
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
