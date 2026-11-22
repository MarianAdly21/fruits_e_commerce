import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void buildErrorBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(errorMessage)));
}
