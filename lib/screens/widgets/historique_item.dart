import 'package:depenses/core/models/historique.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:flutter/material.dart';

class HistoriqueItem extends StatelessWidget {
  const HistoriqueItem({super.key, required this.item});

  final Historique item;

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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: AppColor.backgroundColorWhite,
                    borderRadius: BorderRadius.circular(22)),
                child: Image.asset(item.icon),
              ),
              spaceWidth(8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subtitle(
                      label: item.troncateLabel,
                      extra: {'fontWeight': FontWeight.w500}),
                  text(
                      label: item.typeLabel,
                      extra: {'fontWeight': FontWeight.w300}),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              text(
                  label: "${formatMontant(item.montant)}FCFA",
                  extra: {'fontWeight': FontWeight.w400}),
              text(
                  label: item.dateValue,
                  extra: {'fontWeight': FontWeight.w300}),
            ],
          )
        ],
      ),
    );
  }
}
