import 'package:flutter/material.dart';
import 'package:grocery_mart_app/core/services/favourite_service.dart';
import 'package:grocery_mart_app/core/utils/constants/app_colors.dart';
import 'package:grocery_mart_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteService = Provider.of<FavoriteService>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Favourite',
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: FutureBuilder<List<FavoriteItem>>(
        future: favoriteService.getFavoriteItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => Divider(
                    color: AppColors.grey,
                    thickness: 0.5,
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      leading: Image.asset(
                        items[index].image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(items[index].name),
                      subtitle: Text(items[index].description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(items[index].price),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomButton(
                  color: AppColors.primary,
                  text: 'Add All to Cart',
                  onPressed: () {
                    // Implement add all to cart functionality if needed
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}