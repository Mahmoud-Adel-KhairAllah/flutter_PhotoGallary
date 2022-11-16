import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_photo_gallary/Module/GallaryPhoto/GallaryPhotoController.dart';
import 'package:flutter_photo_gallary/Widgets/customeWidgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../DetailesPhoto/DetailesPhotoScreen.dart';

class GallaryPhotoScreen extends StatelessWidget {
  GallaryPhotoScreen({super.key});
  GallaryPhotoController gallaryPhotoController =
      Get.put(GallaryPhotoController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 1,
              child: buildlistViewTabBar(size),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                flex: 15,
                child: GetBuilder<GallaryPhotoController>(
                  builder: (controller) => gallaryPhotoController
                          .isLoading.value
                      ? Center(
                          child: CustomeWidgets.customLoading(size: 35),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: buildGridView(),
                        ),
                ))
          ],
        ),
      )),
    );
  }

  GridView buildGridView() {
    return GridView.custom(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            pattern: [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
            ]),
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          return InkWell(
            onTap: () {
              Get.to(DetailesPhotoScreen(
                index: index,
              ));
            },
            child: Hero(
              tag: gallaryPhotoController.photos[index].id!,
              child: Container(
                margin: const EdgeInsets.all(2),
                child: CachedNetworkImage(
                  imageUrl: gallaryPhotoController.photos[index].urls!['small'],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: CustomeWidgets.customLoading());
                  },
                  errorWidget: (context, url, error) {
                    return CustomeWidgets.errorIcon();
                  },
                ),
              ),
            ),
          );
        }, childCount: gallaryPhotoController.photos.length));
  }

  ListView buildlistViewTabBar(Size size) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: gallaryPhotoController.orders.length,
      itemBuilder: (context, index) {
        return Obx(
          () => InkWell(
            onTap: () {
              gallaryPhotoController.selectIndex.value = index;
              gallaryPhotoController
                  .getPhotoOrderBy(gallaryPhotoController.orders[index]);
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: size.width / 3,
                margin: EdgeInsets.fromLTRB(index == 0 ? 15 : 5, 0, 5, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        index == gallaryPhotoController.selectIndex.value
                            ? 20
                            : 15),
                    color: index == gallaryPhotoController.selectIndex.value
                        ? Colors.grey[700]
                        : Colors.grey[200]),
                child: Center(
                    child: Text(
                  gallaryPhotoController.orders[index],
                  style: TextStyle(
                      color: index == gallaryPhotoController.selectIndex.value
                          ? Colors.white
                          : Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ))),
          ),
        );
      },
    );
  }
}
