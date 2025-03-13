import 'package:depenses/screens/home/widgets/HomeTopBar.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('dd MM yyyy').format(DateTime.now());

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('dd MM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppSize.bodyPadding),
        child: Column(
          children: [
            const HomeTopBar(),
            spaceHeight(AppSize.spacing),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: AppColor.backgroundColorWhite,
                  borderRadius:
                      BorderRadius.circular(AppSize.borderRadiusLarge)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(label: "Dépenses du ", fontSize: 18.0),
                      GestureDetector(
                        onTap: () => _selectedDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.circular(AppSize.borderRadius)),
                          child: Row(
                            children: [
                              Text(formattedDate,
                                  style: TextStyle(fontSize: 16)),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  spaceHeight(AppSize.spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(
                        label: "25 000",
                        fontSize: AppSize.largeTitle,
                        extra: {"fontWeight": FontWeight.w600},
                      ),
                      spaceWidth(8.0),
                      subtitle(label: "FCFA")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
