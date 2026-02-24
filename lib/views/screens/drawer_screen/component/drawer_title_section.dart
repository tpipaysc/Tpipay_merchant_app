import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controlller.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_switch.dart';
import 'package:lekra/views/screens/drawer_screen/component/row_title.dart';

class DrawerTitleSection extends StatelessWidget {
  const DrawerTitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, bottom: 40),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 3) {
              return Row(
                children: [
                  SvgPicture.asset(
                    Assets.svgsVolumeUp,
                    height: 24,
                    width: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Payment Sound",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                  ),
                  GetBuilder<BasicController>(builder: (basicController) {
                    return SizedBox(
                        width: 100, // Fixed width for the toggle
                        child: Switch(
                            value: basicController.isNotificationSound,
                            onChanged: (val) =>
                                basicController.setIsNotificationSound(val)));
                  })
                ],
              );
            }
            final int dataIndex = index > 3 ? index - 1 : index;
            final drawerData = drawerTitleList[dataIndex];

            return RowOFTitle(
              drawerTitleRowModel: drawerData,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(height: 30);
          },
          itemCount: drawerTitleList.length + 1),
    );
  }
}
