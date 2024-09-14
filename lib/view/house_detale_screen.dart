import 'package:flutter/material.dart';
import 'package:real_estate_app/model/real_estate_model.dart';
import 'package:real_estate_app/utils/colors.dart';

class HouseDetaleScreen extends StatefulWidget {
  final House house;
  const HouseDetaleScreen({super.key, required this.house});

  @override
  State<HouseDetaleScreen> createState() => _HouseDetaleScreenState();
}

class _HouseDetaleScreenState extends State<HouseDetaleScreen> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              PriceFavoriteAndBackButton(size, context),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.house.name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.house.place,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HouseInfo(
                              Icons.bed_outlined, "${widget.house.beds} Beds"),
                          HouseInfo(Icons.bathtub_outlined,
                              "${widget.house.baths} Bath"),
                          HouseInfo(Icons.fullscreen, "${widget.house.size} m"),
                        ]),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      widget.house.description,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              width: size.width,
              height: 150,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.0)
                  ])),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              alignment: Alignment(0, 1),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: bannerColor1,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                          child: Text(
                            "Successfully Booked",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        backgroundColor: Colors.green,
                        shape: StadiumBorder(),
                        behavior: SnackBarBehavior.floating,
                      ));
                    },
                    child: Container(
                      width: size.width / 1.4,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container HouseInfo(icon, name) => Container(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        color: Colors.black12.withOpacity(0.04),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 7,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            )
          ],
        ),
      );

  Container PriceFavoriteAndBackButton(Size size, BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.house.image),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$${widget.house.price}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text: "/month",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: Icon(
                    isLiked == false ? Icons.favorite_border : Icons.favorite,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
