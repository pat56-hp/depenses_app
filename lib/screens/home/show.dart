import 'package:depenses/core/models/historique.dart';
import 'package:depenses/screens/widgets/appbar_return_back.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShowItem extends StatelessWidget {
  const ShowItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Historique historique = Get.arguments;

    return Scaffold(
      //backgroundColor: AppColor.backgroundColorWhite,
      appBar: AppBar(
        leading: const AppBarReturnBack(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.bodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppSize.bodyPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        title(
                          label: "${formatMontant(historique.montant)}FCFA",
                          size: 30.0,
                        ),
                        spaceHeight(4.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/tags.svg',
                              color: AppColor.iconColor,
                              width: AppSize.icon,
                            ),
                            spaceWidth(8.0),
                            Expanded(
                              child: text(
                                  label: historique.libelle,
                                  extra: {'fontWeight': FontWeight.w300},
                                  fontSize: AppSize.subtitle),
                            ),
                          ],
                        )
                      ],
                    )),
                    spaceWidth(8.0),
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColor.backgroundColorWhite,
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset(historique.icon),
                    )
                  ],
                ),
              ),
              spaceHeight(40.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: AppSize.paddingVertical,
                    horizontal: AppSize.paddingHorizontal),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                  color: AppColor.backgroundColorWhite,
                ),
                child: Column(
                  children: [
                    Property(
                      title: 'Type',
                      value: historique.typeLabel,
                    ),
                    spaceHeight(20.0),
                    Property(
                      title: 'Montant',
                      value: "${formatMontant(historique.montant)}FCFA",
                    ),
                    spaceHeight(20.0),
                    Property(
                      title: 'Date',
                      value: historique.dateValue,
                    ),
                    spaceHeight(20.0),
                    Property(
                      title: 'Description',
                      value: historique.description ?? "Aucune description",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Property extends StatelessWidget {
  const Property({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  subtitle(
                      label: title, extra: {'fontWeight': FontWeight.w400}),
                  spaceWidth(8.0),
                ],
              ),
            ),
            Expanded(
                child:
                    subtitle(label: value, extra: {'textAlign': TextAlign.end}))
          ],
        ),
      ],
    );
  }
}
