import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';

class CalendarSection extends StatefulWidget {
  const CalendarSection(
      {super.key, required this.selectedDate, required this.formattedDate});

  final Function selectedDate;
  final String formattedDate;

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingHorizontal),
      decoration: BoxDecoration(
          color: AppColor.backgroundColorWhite,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusLarge)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(label: "Dépenses du ", fontSize: 18.0),
              spaceWidth(8.0),
              GestureDetector(
                onTap: () => widget.selectedDate(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(AppSize.borderRadius)),
                  child: Row(
                    children: [
                      text(
                          label: widget.formattedDate,
                          extra: {'fontWeight': FontWeight.w300}),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              )
            ],
          ),
          spaceHeight(AppSize.paddingHorizontal),
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
    );
  }
}
