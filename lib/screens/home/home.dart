import 'package:depenses/screens/home/controllers/home_controller.dart';
import 'package:depenses/screens/home/widgets/stat_total.dart';
import 'package:depenses/screens/home/widgets/home_top_bar.dart';
import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/screens/widgets/historique_item.dart';
import 'package:depenses/screens/widgets/input_widget.dart';
import 'package:depenses/screens/widgets/loading_circular_progress.dart';
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
  final TextEditingController _libelleController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //Selection de date pour l'historique
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _homeController.selectedDateToList.value,
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

    if (picked != null && picked != _homeController.selectedDateToList.value) {
      setState(() {
        _homeController.selectedDateToList.value = picked;
        _homeController.formattedDateToList.value =
            DateFormat('dd MMM yyyy', 'fr_FR').format(picked);

        //Appel de la fonction de recuperation des depenses
        //_homeController.historiques();
      });
    }
  }

  //Selection de date pour l'ajout
  Future<void> _selectedDateAdd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _homeController.selectedDateToCreate.value,
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
        _homeController.selectedDateToCreate.value = picked;
        _homeController.formattedDateToCreate.value =
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
  void initState() {
    super.initState();
    _homeController.historique();
  }

  @override
  Widget build(BuildContext context) {
    //Envoie verification des datas et envoie au server
    void saveData() {
      final libelle = _libelleController.text;
      final montant = _montantController.text;
      final description = _descriptionController.text;

      //On verifie si tous les champs sont renseignés
      if (libelle.isEmpty) {
        _homeController.libelleError.value = "Le libelle est requis";
        return;
      }

      //Si le montant est vide
      if (montant.isEmpty) {
        _homeController.montantError.value = "Le montant est requis";
        return;
      }

      //Si le montant n'est pas un nombre
      if (!montant.isNum) {
        _homeController.montantError.value = "Le montant doit être un nombre";
        return;
      }

      //Envoie du formulaire
      _homeController.createHistorique(
          libelle: libelle,
          montant: int.parse(montant),
          description: description);

      //print('ok');
    }

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
                              _homeController.typeSelectedToCreate.value =
                                  types[index]['value'];
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _homeController
                                            .typeSelectedToCreate.value ==
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
                                    groupValue: _homeController
                                        .typeSelectedToCreate.value,
                                    onChanged: (value) {
                                      _homeController
                                          .typeSelectedToCreate.value = value;
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
                    InputWidget(
                      controller: _libelleController,
                      hintText: 'Libéllé',
                      prefixIcon: 'assets/icons/tags.svg',
                      errorText: _homeController.libelleError.isNotEmpty
                          ? _homeController.libelleError.value
                          : null,
                    ),
                    spaceHeight(18.0),
                    InputWidget(
                      controller: _montantController,
                      hintText: 'Montant',
                      prefixIcon: 'assets/icons/tags.svg',
                      keyboardType: TextInputType.number,
                      errorText: _homeController.montantError.isNotEmpty
                          ? _homeController.montantError.value
                          : null,
                    ),
                    spaceHeight(18.0),
                    InputWidget(
                      controller: _descriptionController,
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
                                        label: _homeController
                                            .formattedDateToCreate.value,
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
                      child: Obx(() {
                        return ButtonWidget(
                          label: 'Enregistrer',
                          labelSize: AppSize.subtitle,
                          verticalPadding: AppSize.paddingVertical,
                          horizontalPadding: 10.0,
                          buttonColor: AppColor.buttonLightColor,
                          onPressed: () => saveData(),
                          loading: _homeController.loadingToCreate.value,
                        );
                      }),
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
            Obx(() {
              return StatSection(
                selectedDate: _selectedDate,
                formattedDate: _homeController.formattedDateToList.value,
                solde: _homeController.solde.value,
                totalRevenues: _homeController.totalRevenues.value,
                totalDepenses: _homeController.totalDepenses.value,
              );
            }),
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
                        onTap: () async {
                          await _selectedDate(context);
                          _homeController.historique();
                        },
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
                              Obx(() {
                                return text(
                                    label: _homeController
                                        .formattedDateToList.value,
                                    extra: {'fontWeight': FontWeight.w300});
                              }),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  spaceHeight(AppSize.paddingVertical),
                  Obx(() {
                    return _homeController.loadingToList.value
                        ? const Expanded(
                            child: Center(child: LoadingCircularProgress()))
                        : Expanded(
                            child: _homeController.historiques.isNotEmpty
                                ? ListView.builder(
                                    // shrinkWrap: true,
                                    //physics: const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        _homeController.historiques.length,
                                    itemBuilder: (context, index) =>
                                        HistoriqueItem(
                                      item: _homeController.historiques[index],
                                    ),
                                  )
                                : Center(
                                    child: subtitle(
                                        label: 'Aucune dépense enregistrée')),
                          );
                  }),
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
