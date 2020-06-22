import 'package:cov_scanner/constants.dart';
import 'package:cov_scanner/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),

//wrap singlechildscrollview for correct displaying in small density devices
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
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
                    SizedBox(height: 4),
                    Text(
                      "How to scan :",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
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
          style:
          Theme.of(context).textTheme.bodyText1.copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
