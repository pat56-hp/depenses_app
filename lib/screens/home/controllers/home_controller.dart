import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxInt typeSelected = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString formattedDate =
      DateFormat('dd MMM yyyy', 'fr_FR').format(DateTime.now()).obs;
}
