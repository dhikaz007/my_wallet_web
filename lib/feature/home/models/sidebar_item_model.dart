part of 'models.dart';

class SidebarItemModel {
  final String title;
  final IconData? icon;
  final String? svgIcon;
  final String? route;
  final List<SidebarItemModel> children;

  SidebarItemModel({
    required this.title,
    this.icon,
    this.svgIcon,
    this.route,
    this.children = const [],
  });

  @override
  String toString() {
    return 'SidebarItemModel(title: $title, icon: $icon, svgIcon: $svgIcon, route: $route, children: $children)';
  }
}
