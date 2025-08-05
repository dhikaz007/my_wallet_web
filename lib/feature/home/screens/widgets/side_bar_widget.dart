part of 'widgets.dart';

class SideBarWidget extends StatefulWidget {
  final bool isExpand;
  const SideBarWidget({super.key, required this.isExpand});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  late final List<ExpansionTileController> _controller;
  late List<bool> _isTileExpanded;
  @override
  void initState() {
    super.initState();
    Modular.to.addListener(_onRouteChanged);
    _controller =
        List.generate(_sidebarItems.length, (_) => ExpansionTileController());
    _isTileExpanded = List.generate(_sidebarItems.length, (_) => false);
  }

  @override
  void dispose() {
    super.dispose();
    Modular.to.removeListener(_onRouteChanged);
  }

  void _onRouteChanged() {
    setState(() {});
  }

  final List<SidebarItemModel> _sidebarItems = [
    SidebarItemModel(
      title: 'Home',
      icon: Icons.home,
      route: '/',
      children: [
        SidebarItemModel(
          title: 'Dashboard Expenses',
          svgIcon: IconsApp.icBills,
          route: '/dashboard-expenses',
        ),
      ],
    ),
    SidebarItemModel(
      title: 'Expenses',
      svgIcon: IconsApp.icBills,
      route: '/expenses',
      children: [
        SidebarItemModel(
          title: 'Daily',
          svgIcon: IconsApp.icBills,
          route: '/expenses/daily',
        ),
        SidebarItemModel(
          title: 'Monthly',
          svgIcon: IconsApp.icBills,
          route: '/expenses/monthly',
        ),
      ],
    ),
    SidebarItemModel(
      title: 'Profile',
      icon: Icons.person,
      route: '/profile',
      children: [
        SidebarItemModel(
          title: 'Database',
          icon: Icons.data_array,
          route: '/profile/database',
        )
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = Modular.to.path;
    // final size = MediaQuery.sizeOf(context);

    return AnimatedContainer(
      curve: Curves.easeInOutQuad,
      duration: const Duration(milliseconds: 500),
      // width: widget.isExpand ? size.width * .12 : size.width * .4,
      width: widget.isExpand ? 60 : 200,
      child: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemBuilder: (context, index) {
            final item = _sidebarItems[index];

            final isSelected =
                item.children.any((sub) => currentRoute == sub.route);

            return Theme(
              data: ThemeData(dividerColor: ColorApp.transparent),
              child: ExpansionTile(
                controller: _controller[index],
                initiallyExpanded:
                    _isTileExpanded[index], // gunakan status lokal
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isTileExpanded[index] = expanded;
                  });
                },
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(left: 16),
                leading: item.svgIcon != null
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: SvgApp(asset: item.svgIcon ?? ''),
                      )
                    : Icon(item.icon,
                        color: isSelected ? ColorApp.primary : ColorApp.black),
                title: widget.isExpand
                    ? const SizedBox.shrink()
                    : TextApp(
                        text: item.title,
                        size: FontAppSize.font_16,
                        weight: FontAppWeight.medium,
                        color: isSelected ? ColorApp.primary : ColorApp.black,
                      ),
                trailing: widget.isExpand
                    ? const SizedBox.shrink()
                    : Icon(
                        _isTileExpanded[index]
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: isSelected ? ColorApp.primary : ColorApp.black),
                children: item.children.map((subItem) {
                  final isSubSelected = currentRoute == subItem.route;
                  if (widget.isExpand) return const SizedBox.shrink();
                  return ListTile(
                    visualDensity: VisualDensity.compact,
                    contentPadding: const EdgeInsets.only(left: 0),
                    title: TextApp(
                      text: subItem.title,
                      size: FontAppSize.font_14,
                      weight: FontAppWeight.medium,
                      color: isSubSelected ? ColorApp.primary : ColorApp.black,
                    ),
                    onTap: () => Modular.to.navigate(subItem.route!),
                  );
                }).toList(),
              ),
            );

            // return ListTile(
            //   visualDensity: VisualDensity.compact,
            //   contentPadding: EdgeInsets.zero,
            //   selectedColor: ColorApp.primary,
            //   selected: isSelected,
            //   leading: item.svgIcon != null
            //       ? SizedBox(
            //           width: 20,
            //           height: 20,
            //           child: SvgApp(asset: item.svgIcon ?? ''),
            //         )
            //       : Icon(
            //           item.icon,
            //           color: isSelected ? ColorApp.primary : ColorApp.black,
            //         ),
            //   title: widget.isExpand
            //       ? null
            //       : TextApp(
            //           text: item.title,
            //           size: FontAppSize.font_16,
            //           weight: FontAppWeight.medium,
            //           color: isSelected ? ColorApp.primary : ColorApp.black,
            //         ),
            //   trailing: widget.isExpand
            //       ? null
            //       : Icon(
            //           Icons.arrow_drop_down,
            //           color: isSelected ? ColorApp.primary : ColorApp.black,
            //         ),
            //   onTap: () {
            //     Modular.to.navigate(item.route!);
            //   },
            // );
          },
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: _sidebarItems.length,
        ),
      ),
    );
  }
}
