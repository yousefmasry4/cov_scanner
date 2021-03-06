import 'dart:async';
import 'package:cov_scanner/constants.dart';
import 'package:cov_scanner/utility/Routes.dart';
import 'package:cov_scanner/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multipart_request/multipart_request.dart';
import "dart:io";
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  String nsba="0";


  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("check the internet connection and retry or try in another time."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _doSomething() async {
    setState(() {
      nsba="0";
    });
    String aaa;
    // IP.ip.substring(0,IP.ip.length-1)
    String ip = IP.ip.substring(0, IP.ip.length - 1) + "/test";
    var request = MultipartRequest();

    request.setUrl(ip);
    request.addFile("image", _image.path);

    Response response = request.send();

    response.onError = () {
      _btnController.stop();
      showAlertDialog(context);
    };



  response.progress.listen((int progress){
    print("progress from response object " + progress.toString());
    setState(() {
      nsba=progress.toString();
    });
  });
    response.onComplete = (response) {
      print(response == "00" ? -1 : 1);
      _btnController.success();

      setState(() {
        nsba="0";
        Routes.m1=response != "00" ?"You have positive result,":"your have a negative result";
        Routes.m2=response != "00" ?"please check your nearest \nhospital":", please stay safe";
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.info, (Route<dynamic> route) => false);
    };


  }

  File _image = null;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Widget showImage() {
    return Image.file(
      _image,
      scale: 15,
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _image == null
          ? RaisedButton.icon(
              onPressed: () {
                getImage();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text(
                'Select image',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.image,
                color: Colors.white,
              ),
              textColor: Colors.white,
              splashColor: Colors.red,
              color: Colors.green,
            )
          : Container(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Center(
              child:nsba != "100"?Text(
                "uploading $nsba %",
                style: GoogleFonts.varela(
                  textStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                overflow: TextOverflow.clip,
              ):Text(
                "processing",
                style: GoogleFonts.alef(
                  textStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                overflow: TextOverflow.clip,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: RoundedLoadingButton(
                child: Text('start testing',
                    style: TextStyle(color: Colors.white)),
                height: 35,
                animateOnTap: true,
                color: Colors.blueGrey,
                width: MediaQuery.of(context).size.width-30,
                controller: _btnController,
                onPressed: _doSomething,
              ),
            ),
          ],
        ),
      ),
      appBar: buildAppBar(),

//wrap singlechildscrollview for correct displaying in small density devices
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsetsDirectional.only(top: 20),
                color: kPrimaryColor.withOpacity(0.03),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Scan your X-ray or CT to check if it has COVID-19 or not based on AI algorithms with 99.5% accuracy ",
                          style: GoogleFonts.alef(
                            textStyle: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "${corona_corona.country_name} - Last update ${corona_corona.corona_data.last.Date.substring(0, 10)}",
                            style: GoogleFonts.alice(
                              textStyle: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
              padding:
                  EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: <Widget>[
                  InfoCard(
                    title: "Confirmed",
                    iconColor: Color(0xFFFF8C00),
                  ),
                  InfoCard(
                    title: "Deaths",
                    iconColor: Color(0xFFFF2D55),
                  ),
                  InfoCard(
                    title: "Recovered",
                    iconColor: Color(0xFF50E3C2),
                  ),
                  InfoCard(
                    title: "Active",
                    iconColor: Color(0xFF5856D6),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                  child: _image == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Important steps before start",
                              style: GoogleFonts.adamina(
                                textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "- You need to select an HD image",
                                    style: GoogleFonts.adamina(
                                      textStyle: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "-You have to use a light behind the image",
                                    style: GoogleFonts.adamina(
                                      textStyle: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "-You can only upload x-ray and CT to prevent blocking",
                                    style: GoogleFonts.adamina(
                                      textStyle: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Text(
                              "Selected image",
                              style: GoogleFonts.adamina(
                                textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: showImage(),
                            ),
                            SizedBox(height:5,),
                            InkWell(
                              onTap: (){
                               getImage();
                              },
                              child:Text(
                                "Change",
                                style: GoogleFonts.adamina(
                                  textStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${_image.path.split("/").last.toString().substring(12)}",
                              style: GoogleFonts.adamina(
                                textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        )),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      title: Text(
        "COVID-19 Scanner",
        style: GoogleFonts.amethysta(
          textStyle: TextStyle(
            color: Colors.lightGreen,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        overflow: TextOverflow.clip,
      ),
      leading: IconButton(
        icon: Image.asset("images/logo.png"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.info_outline,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
