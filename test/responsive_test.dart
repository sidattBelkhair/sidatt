// test/responsive_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sidatt_portfolio/main.dart';
import 'package:sidatt_portfolio/widgets/responsive/responsive_layout.dart';

void main() {
  testWidgets('App renders on mobile (360x800)', (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    tester.binding.window.physicalSizeTestValue = const Size(360, 800);
    
    await tester.pumpWidget(const PortfolioApp());
    
    expect(find.byType(ResponsiveLayout), findsWidgets);
  });

  testWidgets('App renders on tablet (768x1024)', (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    tester.binding.window.physicalSizeTestValue = const Size(768, 1024);
    
    await tester.pumpWidget(const PortfolioApp());
    
    expect(find.byType(ResponsiveLayout), findsWidgets);
  });

  testWidgets('App renders on desktop (1920x1080)', (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
    
    await tester.pumpWidget(const PortfolioApp());
    
    expect(find.byType(ResponsiveLayout), findsWidgets);
  });

  testWidgets('ResponsiveHelper correctly identifies screen sizes',
      (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    tester.binding.window.physicalSizeTestValue = const Size(500, 800);
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ResponsiveHelper.isMobile(context) ? 'Mobile' : 'Not Mobile',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
    
    expect(find.text('Mobile'), findsOneWidget);
  });
}
