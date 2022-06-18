import 'package:flutter/material.dart';

import 'app_config.dart';
import 'food_ordering_app.dart';

void main() => runApp(
      AppConfig(
        apiBaseUrl: '',
        child: FoodOrderingApp(),
      ),
    );
