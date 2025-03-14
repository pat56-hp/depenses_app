import 'package:depenses/screens/configuration/widget/config_item.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';

class Configuration extends StatelessWidget {
  const Configuration({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _configItem = [
      //{"icon": "assets/icons/briefcase.svg", "name": "Catégories", "link": ""},
      {"icon": "assets/icons/user.svg", "name": "Mon profil", "link": ""},
      {
        "icon": "assets/icons/lock.svg",
        "name": "Modifier mon mot de passe",
        "link": ""
      },
      {"icon": "assets/icons/exit.svg", "name": "Me déconnecter", "link": ""},
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: text(
          label: 'Paramètres',
          fontSize: AppSize.title,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSize.paddingHorizontal),
          child: Center(
            child: Container(
                //height: 200,
                decoration: BoxDecoration(
                  color: AppColor.backgroundColorWhite,
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                ),
                padding: const EdgeInsets.all(AppSize.paddingHorizontal),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _configItem.length,
                    itemBuilder: (context, index) => (ConfigItem(
                          lenght: _configItem.length,
                          index: index,
                          label: _configItem[index]["name"].toString(),
                          icon: _configItem[index]["icon"].toString(),
                          link: _configItem[index]["link"].toString(),
                        )))),
          ),
        ),
      ),
    );
  }
}
