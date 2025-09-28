import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'shared/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 13 Pro size as base
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp.router(
                title: 'Portfolio - Flutter Developer',
                debugShowCheckedModeBanner: false,

                // Theme Configuration
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.themeMode,

                // Router Configuration
                routerConfig: AppRouter.router,

                // App Configuration
                builder: (context, child) {
                  // Set system UI overlay style based on theme
                  SystemChrome.setSystemUIOverlayStyle(
                    AppTheme.getSystemUiOverlayStyle(
                      themeProvider.isDarkMode,
                    ),
                  );

                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(
                        MediaQuery.of(context).size.width < 360 ? 0.8 :
                        MediaQuery.of(context).size.width < 400 ? 0.9 :
                        MediaQuery.of(context).size.width > 1400 ? 1.1 : 1.0,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
