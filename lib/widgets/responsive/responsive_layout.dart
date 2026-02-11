// widgets/responsive/responsive_layout.dart
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;

  const ResponsiveLayout({
    required this.mobileBody,
    this.tabletBody,
    this.desktopBody,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile
          return mobileBody;
        } else if (constraints.maxWidth < 1200) {
          // Tablet
          return tabletBody ?? mobileBody;
        } else {
          // Desktop
          return desktopBody ?? (tabletBody ?? mobileBody);
        }
      },
    );
  }
}

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  static double getResponsivePadding(BuildContext context) {
    if (isMobile(context)) return 16;
    if (isTablet(context)) return 24;
    return 32;
  }

  static double getResponsiveFontSize(
    BuildContext context, {
    double mobile = 14,
    double tablet = 16,
    double desktop = 18,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static int getResponsiveCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}
