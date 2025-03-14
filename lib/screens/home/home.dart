import 'package:depenses/screens/home/widgets/calendar_section.dart';
import 'package:depenses/screens/home/widgets/home_top_bar.dart';
import 'package:depenses/screens/widgets/historique_item.dart';
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
  String formattedDate =
      DateFormat('dd MMM yyyy', 'fr_FR').format(DateTime.now());

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('fr', 'FR'),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('dd MMM yyyy', 'fr_FR').format(picked);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeTopBar(),
            spaceHeight(AppSize.spacing),
            CalendarSection(
                selectedDate: _selectedDate, formattedDate: formattedDate),
            spaceHeight(AppSize.spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  subtitle(label: 'Historiques des dépenses'),
                  spaceHeight(AppSize.paddingVertical),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      //physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) => const HistoriqueItem(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
