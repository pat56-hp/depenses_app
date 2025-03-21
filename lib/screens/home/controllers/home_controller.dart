import 'package:depenses/core/models/historique.dart';
import 'package:depenses/core/routes/api_end_point.dart';
import 'package:depenses/core/services/api_service.dart';
import 'package:depenses/utils/helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxInt typeSelectedToList = 0.obs;
  Rx<DateTime> selectedDateToList = DateTime.now().obs;
  RxString formattedDateToList =
      DateFormat('dd MMM yyyy', 'fr_FR').format(DateTime.now()).obs;

  RxInt typeSelectedToCreate = 0.obs;
  Rx<DateTime> selectedDateToCreate = DateTime.now().obs;
  RxString formattedDateToCreate =
      DateFormat('dd MMM yyyy', 'fr_FR').format(DateTime.now()).obs;

  RxList<Historique> historiques = <Historique>[].obs;

  RxInt solde = 0.obs;
  RxInt totalDepenses = 0.obs;
  RxInt totalRevenues = 0.obs;

  RxBool loadingToList = false.obs;
  RxBool loadingToCreate = false.obs;
  RxString libelleError = "".obs;
  RxString montantError = "".obs;

  //Recuperation de l'historique en fonction de la date
  Future<void> historique() async {
    loadingToList.value = true;

    try {
      final response = await ApiService.get(ApiEndPoint.historique, query: {
        "date": selectedDateToList.value.toString(),
      });

      final datas = response.data;
      final historiqueResponseData = datas['data'];
      solde.value = datas['solde'];
      totalDepenses.value = datas['depenses'];
      totalRevenues.value = datas['revenus'];

      //Mise à jour de la liste
      historiques.value = (historiqueResponseData as List)
          .map((historique) => Historique.fromJson(historique))
          .toList();

      loadingToList.value = false;
    } catch (e) {
      loadingToList.value = false;
      print(
          "Une erreur s'est produite lors de la recuperation de l'historique : ${e.toString()}");
    }
  }

  //Création d'une nouvelle entrée ou sortie
  Future<void> createHistorique(
      {required String libelle,
      required int montant,
      String? description}) async {
    loadingToCreate.value = true;

    try {
      final response = await ApiService.post(ApiEndPoint.historique, {
        "libelle": libelle,
        "description": description,
        "montant": montant,
        "date": selectedDateToCreate.value.toString(),
        "type": typeSelectedToCreate.value,
      });

      loadingToCreate.value = false;

      //loadingToList.value = false;

      //On ferme le modal
      Get.back();
      showSnackBarWidget(
          type: 'success', content: 'Informations enregistées avec succes');

      //On initialise la date de la page home sur celle selectionnee dans le modal
      selectedDateToList.value = selectedDateToCreate.value;
      formattedDateToList.value = formattedDateToCreate.value;

      //On met les valeurs a l'initial
      libelleError.value = "";
      montantError.value = "";
      selectedDateToCreate.value = DateTime.now();
      typeSelectedToCreate.value = 0;
      libelleError.value = "";

      historique();
    } catch (e) {
      loadingToCreate.value = false;
      loadingToList.value = false;
      print(
          "Une erreur s'est produite lors de la creation de l'historique : ${e.toString()}");
    }
  }
}
