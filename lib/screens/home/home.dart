import 'package:depenses/screens/home/controllers/home_controller.dart';
import 'package:depenses/screens/home/widgets/stat_total.dart';
import 'package:depenses/screens/home/widgets/home_top_bar.dart';
import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/screens/widgets/historique_item.dart';
import 'package:depenses/screens/widgets/input_widget.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.find<HomeController>();

  DateTime selectedDate = DateTime.now();
  String formattedDate =
      DateFormat('dd MMM yyyy', 'fr_FR').format(DateTime.now());

  //Selection de date pour l'historique
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('fr', 'FR'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: AppColor.backgroundColor,
              hintColor: AppColor.inputPlaceholderColor,
              colorScheme: const ColorScheme.light(
                  primary: AppColor.buttonLightColor,
                  onPrimary: AppColor.backgroundColorWhite,
                  surface: AppColor.backgroundColor,
                  onSurface: AppColor.textColor)),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('dd MMM yyyy', 'fr_FR').format(picked);
      });
    }
  }

  //Selection de date pour l'ajout
  Future<void> _selectedDateAdd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _homeController.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('fr', 'FR'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColor.backgroundColor,
            hintColor: AppColor.inputPlaceholderColor,
            colorScheme: const ColorScheme.light(
              primary: AppColor.buttonLightColor,
              onPrimary: AppColor.backgroundColorWhite,
              surface: AppColor.backgroundColor,
              onSurface: AppColor.textColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _homeController.selectedDate.value = picked;
        _homeController.formattedDate.value =
            DateFormat('dd MMM yyyy', 'fr_FR').format(picked);
      });
    }
  }

  final List<Map<String, dynamic>> types = [
    {"title": "Revenue", "value": 0},
    {"title": "Dépense", "value": 1},
  ];

  int typeSelected = 0;

  @override
  Widget build(BuildContext context) {
    void openPopup() {
      Get.dialog(
        Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSize.buttonPaddingHorizontal),
                margin: const EdgeInsets.symmetric(
                    horizontal: AppSize.paddingHorizontal),
                decoration: BoxDecoration(
                    color: AppColor.backgroundColorWhite,
                    borderRadius: BorderRadius.circular(AppSize.borderRadius)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(child: title(label: 'Nouvelle dépenses')),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColor.border,
                              borderRadius:
                                  BorderRadius.circular(AppSize.borderRadius),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/cross.svg',
                              width: 15.0,
                              color: AppColor.backgroundColorWhite,
                            ),
                          ),
                        )
                      ],
                    ),
                    spaceHeight(22.0),
                    Obx(() {
                      return Wrap(
                        spacing: 8.0, // ✅ Réduit l'espace entre les options
                        children: List.generate(types.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              _homeController.typeSelected.value =
                                  types[index]['value'];
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _homeController.typeSelected.value ==
                                        types[index]['value']
                                    ? AppColor.border.withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio(
                                    value: types[index]['value'],
                                    groupValue:
                                        _homeController.typeSelected.value,
                                    onChanged: (value) {
                                      _homeController.typeSelected.value =
                                          value;
                                    },
                                    activeColor: AppColor.border,
                                  ),
                                  subtitle(label: types[index]['title']),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                    spaceHeight(18.0),
                    const InputWidget(
                      hintText: 'Libéllé',
                      prefixIcon: 'assets/icons/tags.svg',
                    ),
                    spaceHeight(18.0),
                    const InputWidget(
                      hintText: 'Montant',
                      prefixIcon: 'assets/icons/tags.svg',
                      keyboardType: TextInputType.number,
                    ),
                    spaceHeight(18.0),
                    const InputWidget(
                      hintText: 'Description',
                      prefixIcon: 'assets/icons/comment.svg',
                    ),
                    spaceHeight(18.0),
                    GestureDetector(
                      onTap: () => _selectedDateAdd(context),
                      child: Container(
                        padding: const EdgeInsets.all(AppSize.paddingVertical),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSize.borderRadius),
                          color: AppColor.soldeColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/calendar.svg',
                                    color: AppColor.iconColor,
                                    width: 18,
                                  ),
                                  spaceWidth(8.0),
                                  Obx(() {
                                    return text(
                                        label:
                                            _homeController.formattedDate.value,
                                        extra: {'fontWeight': FontWeight.w300});
                                  }),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    spaceHeight(18.0),
                    SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        label: 'Enregistrer',
                        labelSize: AppSize.subtitle,
                        verticalPadding: AppSize.paddingVertical,
                        horizontalPadding: 10.0,
                        buttonColor: AppColor.buttonLightColor,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        name: 'Nouvelle depense',
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.bodyPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeTopBar(),
            spaceHeight(AppSize.spacing),
            StatSection(
                selectedDate: _selectedDate, formattedDate: formattedDate),
            spaceHeight(AppSize.spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subtitle(label: 'Historiques des dépenses'),
                      GestureDetector(
                        onTap: () => _selectedDate(context),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.soldeColor,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/calendar.svg',
                                color: AppColor.iconColor,
                                width: 18,
                              ),
                              spaceWidth(8.0),
                              text(
                                  label: formattedDate,
                                  extra: {'fontWeight': FontWeight.w300}),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  spaceHeight(AppSize.paddingVertical),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      //physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) => const HistoriqueItem(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.buttonDarkColor,
        child: SvgPicture.asset(
          'assets/icons/plus.svg',
          color: AppColor.backgroundColor,
        ),
        onPressed: () {
          openPopup();
        },
      ),
    );
  }
}
