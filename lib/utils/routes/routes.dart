
part of 'routes_imports.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends $AppRouter {

  @override
  RouteType get defaultRouteType=>RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [

    AutoRoute(page: SplashScreenRoute.page,path: "/"),
    AutoRoute(page:SignUpScreenRoute.page),
    AutoRoute(page: SignInScreenRoute.page),
    AutoRoute(page: HomeScreenRoute.page),

    /// routes go here
  ];
}