import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';

class HistoriqueItem extends StatelessWidget {
  const HistoriqueItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 45,
                width: 45,
                padding: const EdgeInsets.all(AppSize.buttonPaddingHorizontal),
                decoration: BoxDecoration(
                    color: AppColor.backgroundColorWhite,
                    borderRadius: BorderRadius.circular(22)),
              ),
              spaceWidth(8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subtitle(
                      label: 'Achat de timbre',
                      extra: {'fontWeight': FontWeight.w500}),
                  text(
                      label: 'le 05/03/2025',
                      extra: {'fontWeight': FontWeight.w300}),
                ],
              )
            ],
          ),
          text(label: '500 FCFA', extra: {'fontWeight': FontWeight.w400})
        ],
      ),
    );
  }
}
