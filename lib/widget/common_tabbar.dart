
import 'package:flutter/material.dart';
import 'package:fuck_utils/widget/super_container.dart';

enum TabStyle{
  line, card
}

class CommonTabBar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabChange;
  final int defaultTab;
  final TabStyle tabStyle;
  final Color? selectColor;
  final Color? indicatorColor;
  final Color? unselectColor;
  final Color? selectBgColor;
  final Color? unselectBgColor;
  final double? selectFontSize;
  final double? unselectFontSize;
  final double? tabWidth;
  final double? indicatorHeight;
  final double? tabRadius;
  final EdgeInsets? tabPadding;
  final double? padding;
  final double? tabSpace;
  final double? height;
  final bool thinIndicator;
  final Color? dividerColor;
  final double? dividerHeight;
  final bool tabEqual;
  const CommonTabBar(this.tabs, this.onTabChange,{super.key, this.defaultTab = 0, this.height, this.thinIndicator = true,
    this.tabPadding, this.tabSpace, this.tabWidth, this.padding, this.tabStyle = TabStyle.line,
    this.selectColor, this.unselectColor, this.selectBgColor, this.unselectBgColor,
    this.selectFontSize, this.unselectFontSize, this.indicatorColor, this.indicatorHeight, this.tabRadius,
    this.dividerColor, this.dividerHeight, this.tabEqual = false});

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currTab;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabs.length , vsync: this);
    currTab = widget.defaultTab;
  }

  @override
  Widget build(BuildContext context) {
    return widget.tabStyle==TabStyle.card ? SizedBox(height: widget.height?? 28,
      child: ListView.separated(itemBuilder: (c,i){
      Color selectColor = widget.selectColor ?? Theme.of(context).primaryColor;
      Color unselectColor = widget.unselectColor ?? Theme.of(context).primaryColor;
      double selectSize = widget.selectFontSize ?? 14;
      double unselectSize = widget.unselectFontSize ?? 14;
      return SuperContainer(height: widget.height ?? 28, width: widget.tabWidth,
        padding: widget.tabPadding,
        color: (currTab == i ? widget.selectBgColor: widget.unselectBgColor) ?? Colors.transparent,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(widget.tabRadius ?? 8),
            topRight: Radius.circular(widget.tabRadius ?? 8)),
        child: Text(widget.tabs[i], style: TextStyle(color: currTab == i ? selectColor
            : unselectColor, fontSize:  currTab == i ? selectSize : unselectSize),),
        onTap: (){
        setState(() {
          var b = widget.onTabChange(i);
          if(b==true || b==null) currTab = i;
        });
        },
      );
    }, separatorBuilder: (c,i) => SizedBox(width: widget.tabSpace ?? 4,),
        padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
        itemCount: widget.tabs.length, scrollDirection: Axis.horizontal),)
    : Container(height: widget.height ?? 40,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: widget.dividerColor ?? Theme.of(context).dividerColor,
        width: widget.dividerHeight ?? 0
      ))),
      padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
      child: TabBar(
      isScrollable: !widget.tabEqual,
      dividerHeight: 0,
      padding: widget.tabPadding ?? EdgeInsets.symmetric(horizontal: 8),
      // labelPadding: EdgeInsets.symmetric(horizontal: 16),
      indicatorPadding: EdgeInsets.zero,
      indicatorColor: widget.indicatorColor ?? widget.selectColor ?? Theme.of(context).primaryColor,
      indicatorWeight: widget.indicatorHeight ?? 2,
      indicatorSize: widget.thinIndicator ? TabBarIndicatorSize.label : TabBarIndicatorSize.tab,
      labelColor: widget.selectColor ?? Theme.of(context).primaryColor,
      unselectedLabelColor: widget.unselectColor ?? Theme.of(context).colorScheme.tertiary,
      labelStyle: TextStyle(
          color: widget.selectColor ?? Theme.of(context).primaryColor, fontSize: widget.selectFontSize ?? 14),
      unselectedLabelStyle: TextStyle(
          color: widget.unselectColor ?? Theme.of(context).colorScheme.tertiary,
          fontSize: widget.unselectFontSize ?? 14),
      tabs: widget.tabs.map((e) => Tab(text: e,)).toList(),
      onTap: (i) {
        widget.onTabChange(i);
      },
      controller: tabController,
    ),);
  }
}
