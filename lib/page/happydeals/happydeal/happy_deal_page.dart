import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/page/happydeals/happydeal/happydeal_bloc/happydeal_bloc.dart';
import 'package:buoi10/page/happydeals/happydeal/widget/deal_card.dart';
import 'package:buoi10/page/happydeals/dealdetail/deal_detail_page.dart';
import 'package:buoi10/route/route_management.dart';

class HappyDealPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HappyDealBloc()..add(LoadDeals()),
      child: Scaffold(
        appBar: AppBar(title: Text("Happy Deals")),
        body: BlocBuilder<HappyDealBloc, HappyDealState>(
          builder: (context, state) {
            if (state is DealsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DealsLoaded) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: state.deals.length,
                itemBuilder: (context, index) {
                  final deal = state.deals[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.discountScreen, // ✅ Định danh route
                          arguments: deal, // ✅ Truyền đối tượng Deal
                        );

                      },
                  child: deal.id % 2 == 0
                      ? DealCard2(deal: deal)  // Nếu id chẵn, dùng DealCard2
                      : DealCard1(deal: deal), // Nếu id lẻ, dùng DealCard1
                  );
                },
              );
            } else {
              return Center(child: Text("Không có deals nào!"));
            }
          },
        ),
      ),
    );
  }
}
