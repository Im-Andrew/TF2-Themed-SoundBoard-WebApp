// Copyright (c) 2017 Andrew Resto. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'globals.dart';
import "html_template.dart";
import "app_controller.dart";

AppController ctrl;
///Enter the program
Future init() async {
  await loadElements();
  ctrl = new AppController();
}

/// Loads all our initial template
Future<Null> loadElements() async {
  tileTemplate = await new HTMLTemplate("./templates/grid-tile.html")
     ..load();
  selectTemplate = await new HTMLTemplate("./templates/selection-container.html")
    ..load();
  return null;
}


