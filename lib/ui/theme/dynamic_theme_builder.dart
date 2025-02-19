import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revanced_manager/app/app.router.dart';
import 'package:revanced_manager/theme.dart';
import 'package:stacked_services/stacked_services.dart';

class DynamicThemeBuilder extends StatelessWidget {
  const DynamicThemeBuilder({
    Key? key,
    required this.title,
    required this.home,
    required this.localizationsDelegates,
  }) : super(key: key);
  final String title;
  final Widget home;
  final Iterable<LocalizationsDelegate> localizationsDelegates;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        final ThemeData lightDynamicTheme = ThemeData(
          useMaterial3: true,
          canvasColor: lightColorScheme?.surface,
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: lightColorScheme?.surface,
            indicatorColor: lightColorScheme?.secondaryContainer,
            labelTextStyle: MaterialStateProperty.all(
              GoogleFonts.roboto(
                color: lightColorScheme?.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            iconTheme: MaterialStateProperty.all(
              IconThemeData(
                color: lightColorScheme?.onSecondaryContainer,
              ),
            ),
          ),
          scaffoldBackgroundColor: lightColorScheme?.surface,
          colorScheme: lightColorScheme?.harmonized(),
          toggleableActiveColor: lightColorScheme?.primary,
          textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme),
        );
        final ThemeData darkDynamicTheme = ThemeData(
          useMaterial3: true,
          canvasColor: darkColorScheme?.surface,
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: darkColorScheme?.surface,
            indicatorColor: darkColorScheme?.secondaryContainer,
            labelTextStyle: MaterialStateProperty.all(
              GoogleFonts.roboto(
                color: darkColorScheme?.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            iconTheme: MaterialStateProperty.all(
              IconThemeData(
                color: darkColorScheme?.onSecondaryContainer,
              ),
            ),
          ),
          scaffoldBackgroundColor: darkColorScheme?.surface,
          colorScheme: darkColorScheme?.harmonized(),
          toggleableActiveColor: darkColorScheme?.primary,
          textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
        );
        return DynamicTheme(
          themeCollection: ThemeCollection(
            themes: {
              0: lightCustomTheme,
              1: darkCustomTheme,
              2: lightDynamicTheme,
              3: darkDynamicTheme,
            },
            fallbackTheme: lightCustomTheme,
          ),
          builder: (context, theme) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            navigatorKey: StackedService.navigatorKey,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            theme: theme,
            home: home,
            localizationsDelegates: localizationsDelegates,
          ),
        );
      },
    );
  }
}