import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/page/happydeals/dealdetail/dealdetail_bloc/dealdetail_bloc.dart';
import 'package:buoi10/data/model/deal_model.dart';
import 'package:buoi10/route/route_management.dart';



class DiscountScreen extends StatelessWidget {
  final Deal deal;
  DiscountScreen({required this.deal});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DealDetailBloc()..add(LoadDetail(deal: deal)),
      child: Scaffold(
        body: BlocBuilder<DealDetailBloc, DealDetailState>(
          builder: (context, state) {
            if (state is DetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.redAccent, Colors.orangeAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back, color: Colors.white),
                              ),
                              SizedBox(height: 20),
                              Text(
                                state.dealData.name, // Hiển thị tên deal
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(state.dealData.description, style: TextStyle(color: Colors.white, fontSize: 18)),
                                    ],
                                  ),
                                  Spacer(),
                                  Image.network(state.dealData.imageUrl, height: 100),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Terms & Condition",
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),

                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Time slots from 10:00 to 15:00"),
                              SizedBox(width: 10), // Khoảng cách giữa text và ảnh
                              Image.network(
                                "https://drive.google.com/uc?export=view&id=1GMFMADPU0cdMbKLSbEkOMUgv1eP6Ls3z",
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.network(
                                "https://drive.google.com/uc?export=view&id=1DURMoPLnDnzVRGdhXcOa_E52PgqJ4m-n",
                                width: 150,
                                height: 150,
                              ),
                              SizedBox(width: 10), // Khoảng cách giữa ảnh và text
                              Text("Applicable to all branches\nValid until 31st October, 2021"),
                            ],
                          ),
                        ],
                      ),

                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.dealreservation);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: Text("GET IT NOW", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Failed to load deal details"));
            }
          },
        ),
      ),
    );
  }
}

