/// Test EXPLORE tab VISUAL feature DEMO dataset.
//
// Time-stamp: <Tuesday 2024-10-08 07:03:47 +1100 Graham Williams>
//
/// Copyright (C) 2024, Togaware Pty Ltd
///
/// Licensed under the GNU General Public License, Version 3 (the "License");
///
/// License: https://www.gnu.org/licenses/gpl-3.0.en.html
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <https://www.gnu.org/licenses/>.
///
/// Authors: Kevin Wang

library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rattle/features/visual/panel.dart';
import 'package:rattle/main.dart' as app;
import 'package:rattle/tabs/explore.dart';
import 'package:rattle/widgets/image_page.dart';

import 'utils/delays.dart';
import 'utils/goto_next_page.dart';
import 'utils/open_demo_dataset.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Explore tab DEMO dataset:', () {
    testWidgets('Visual feature.', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.pump(interact);

      await openDemoDataset(tester);

      await tester.pump(hack);

      // Navigate to the Explore tab and tap on it.

      final exploreTabFinder = find.text('Explore');
      await tester.tap(exploreTabFinder);
      await tester.pumpAndSettle();

      await tester.pump(interact);

      // Verify if the ExploreTabs widget is shown.

      expect(find.byType(ExploreTabs), findsOneWidget);

      ////////////////////////////////////////////////////////////////////////

      // Visual page

      final visualTabFinder = find.text('Visual');
      expect(visualTabFinder, findsOneWidget);

      // Tap the Visual tab.

      await tester.tap(visualTabFinder);
      await tester.pumpAndSettle();

      // Verify that the VisualPanel is shown.

      expect(find.byType(VisualPanel), findsOneWidget);

      await tester.pump(interact);
      await tester.pump(delay);

      // Find the button by its text.

      final generatePlotButtonFinder = find.text('Generate Plots');
      expect(generatePlotButtonFinder, findsOneWidget);

      // Tap the button.

      await tester.tap(generatePlotButtonFinder);
      await tester.pumpAndSettle();

      await tester.pump(interact);

      // TODO 20241003 gjw BUG NEED TO TAP THE BUTTON TWICE TO GO TO SECOND PAGE.

      await tester.tap(generatePlotButtonFinder);
      await tester.pumpAndSettle();

      // Find the right arrow button in the PageIndicator.

      final rightArrowFinder = find.byIcon(Icons.arrow_right_rounded);
      expect(rightArrowFinder, findsOneWidget);

      // Automatically go to "Box Plot" page 2.

      await tester.pumpAndSettle();

      await tester.pump(interact);

      // Find the text containing "Box Plot".

      final boxPlotFinder = find.textContaining('Box Plot');
      expect(boxPlotFinder, findsOneWidget);

      await tester.pump(hack);

      // Find the image.

      final boxImageFinder = find.byType(ImagePage);
      expect(boxImageFinder, findsOneWidget);

      // TODO 20240827 gjw SOME PLOT TEST IDEAS
      //
      // Can we read the generated SVG file properties to ensure the plot has
      // just been generated and the size is abuotwhat we expect it to be.

      // Tap the right arrow button to go to "Density Plot of Values" page 3.

      await tester.tap(rightArrowFinder);
      await tester.pumpAndSettle();
      await tester.pump(interact);

      // Find the text containing "Density Plot of Values".

      // verifyPage('Density Plot of Values');

      // Find the image.

      final densityImageFinder = find.byType(ImagePage);
      expect(densityImageFinder, findsOneWidget);

      // Tap the right arrow button to go to "Cumulative Plot" page 4.

      // await tester.tap(rightArrowFinder);
      // await tester.pumpAndSettle();
      // await tester.pump(interact);
      await gotoNextPage(tester);

      // Find the text containing "Cumulative Plot".

      // verifyPage('Cumulative Plot');

      // final cumulativePlotFinder = find.textContaining('Cumulative Plot');
      // expect(cumulativePlotFinder, findsOneWidget);

      // Find the image.

      final cumulativeImageFinder = find.byType(ImagePage);
      expect(cumulativeImageFinder, findsOneWidget);

      // Tap the right arrow button to go to "Benford Plots" page 5.

      // await tester.tap(rightArrowFinder);
      // await tester.pumpAndSettle();
      // await tester.pump(interact);
      await gotoNextPage(tester);

      // Find the text containing "Benford Plot".

      // final benfordPlotFinder = find.textContaining('Benford Plot');
      // expect(benfordPlotFinder, findsOneWidget);

      // Find the image.

      // final imageFinder = find.byType(ImagePage);
      // expect(imageFinder, findsOneWidget);
    });
  });
}
