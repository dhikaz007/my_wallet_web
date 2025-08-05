import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'constants/constants.dart';
import 'feature/expenses/cubit/expenses_cubit.dart';
import 'feature/expenses/cubit/type_cubit.dart';
import 'flavors.dart';
import 'routes/routes.dart';
import 'shared/shared.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();
  FlavorMode.appFlavor = Flavor.values.firstWhere((e) => e.name == appFlavor);
  runApp(
    ModularApp(
      module: AppRoutes(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExpensesCubit()),
        BlocProvider(create: (context) => TypeCubit()),
      ],
      child: ScreenUtilInit(
        child: GlobalLoaderOverlay(
          overlayColor: ColorApp.black.withOpacity(.5),
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          overlayWidgetBuilder: (progress) => const LoadingWidget(),
          switchInCurve: Curves.easeInOutQuad,
          switchOutCurve: Curves.easeInOutQuad,
          child: MaterialApp.router(
            title: FlavorMode.name,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Lufga',
              appBarTheme:
                  AppBarTheme(backgroundColor: ColorApp.primary.shade50),
              drawerTheme:
                  const DrawerThemeData(backgroundColor: ColorApp.white),
              scaffoldBackgroundColor: ColorApp.defaultBackgroud,
              colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.primary),
            ),
            routerConfig: Modular.routerConfig,
          ),
        ),
      ),
    );
  }
}
