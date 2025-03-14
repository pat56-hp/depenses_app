import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.paddingHorizontal,
            horizontal: AppSize.paddingHorizontal,
          ),
          decoration: BoxDecoration(
              color: AppColor.soldeColor,
              borderRadius: BorderRadius.circular(AppSize.borderRadius)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/briefcase.svg',
                    //color: Colors.white,
                    width: AppSize.icon,
                    height: AppSize.icon,
                  ),
                  spaceWidth(AppSize.bodyPadding),
                  text(
                    label: 'Solde',
                    //color: AppColor.backgroundColorWhite,
                    fontSize: 18.0,
                    extra: {'fontWeight': FontWeight.w300},
                  )
                ],
              ),
              spaceHeight(10.0),
              Row(
                children: [
                  text(
                      label: '30 000',
                      //color: AppColor.backgroundColorWhite,
                      fontSize: 25.0,
                      extra: {'fontweight': FontWeight.w600}),
                  spaceWidth(10.0),
                  subtitle(
                    label: 'FCFA',
                  )
                ],
              )
            ],
          ),
        ),
        spaceHeight(AppSize.paddingVertical),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.paddingHorizontal,
                  horizontal: AppSize.paddingHorizontal,
                ),
                decoration: BoxDecoration(
                  color: AppColor.backgroundColorWhite,
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColor.revenueColor),
                          child: Image.asset(
                            'assets/images/entree.png',
                          ),
                        ),
                        text(
                          label: 'Revenus',
                          extra: {'fontWeight': FontWeight.w300},
                        )
                      ],
                    ),
                    spaceHeight(10.0),
                    Row(
                      children: [
                        text(label: '50 000', fontSize: AppSize.title),
                        spaceWidth(10.0),
                        text(
                          label: 'FCFA',
                          extra: {'fontWeight': FontWeight.w300},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            spaceWidth(20.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.paddingHorizontal,
                  horizontal: AppSize.paddingHorizontal,
                ),
                decoration: BoxDecoration(
                  color: AppColor.backgroundColorWhite,
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColor.sortieColor),
                          child: Image.asset(
                            'assets/images/sortie.png',
                          ),
                        ),
                        text(
                          label: 'Dépenses',
                          extra: {'fontWeight': FontWeight.w300},
                        )
                      ],
                    ),
                    spaceHeight(10.0),
                    Row(
                      children: [
                        text(label: '25 000', fontSize: AppSize.title),
                        spaceWidth(10.0),
                        text(
                          label: 'FCFA',
                          extra: {'fontWeight': FontWeight.w300},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        /* Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.paddingHorizontal,
            horizontal: AppSize.paddingHorizontal,
          ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
              spaceHeight(AppSize.paddingHorizontal),
            ],
          ),
        ), */
      ],
    );
  }
}
