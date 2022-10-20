import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/components/base_text.dart';
import 'package:flutter_food_app/components/loading.dart';
import 'package:flutter_food_app/model/restaurant.dart';
import 'package:flutter_food_app/screens/restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _buildAndroid(context);
      case TargetPlatform.iOS:
        return _buildIos(context);
      default:
        return _buildAndroid(context);
    }
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildContent(context),
    );
  }

  FutureBuilder<String> _buildContent(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants =
            Restaurant.parseRestaurants(snapshot.data);

        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, restaurants[index]);
          },
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Image.network(
        restaurant.pictureUrl,
        width: 100.0,
      ),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
