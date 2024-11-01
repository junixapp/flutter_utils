
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
  final bool selectBold;
  final double? unselectFontSize;
  final double? tabWidth;
  final double? indicatorHeight;
  final double? indicatorRadius;
  final double? tabRadius;
  final EdgeInsets? tabPadding;
  final double? padding;
  final double? tabSpace;
  final double? height;
  final bool thinIndicator;
  final Color? dividerColor;
  final double? dividerHeight;
  final bool tabEqual;

  const CommonTabBar({super.key, required this.tabs, required this.onTabChange, this.defaultTab = 0, this.height, this.thinIndicator = true,
    this.tabPadding = EdgeInsets.zero, this.tabSpace, this.tabWidth, this.padding, this.tabStyle = TabStyle.line, this.selectBold = false,
    this.selectColor, this.unselectColor, this.selectBgColor, this.unselectBgColor,
    this.selectFontSize, this.unselectFontSize, this.indicatorColor, this.indicatorHeight, this.indicatorRadius, this.tabRadius,
    this.dividerColor, this.dividerHeight, this.tabEqual = true});

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
    var boxHeight = widget.height ?? 40;
    var indHeight = widget.indicatorHeight ?? 4;
    return widget.tabStyle==TabStyle.card ? SizedBox(height: boxHeight,
      child: ListView.separated(itemBuilder: (c,i){
        Color selectColor = widget.selectColor ?? Theme.of(context).primaryColor;
        Color unselectColor = widget.unselectColor ?? Theme.of(context).primaryColor;
        double selectSize = widget.selectFontSize ?? 16;
        double unselectSize = widget.unselectFontSize ?? 16;
        return SuperContainer(height: boxHeight, width: widget.tabWidth,
          padding: widget.tabPadding,
          color: (currTab == i ? widget.selectBgColor: widget.unselectBgColor) ?? Colors.transparent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(widget.tabRadius ?? 8),
              topRight: Radius.circular(widget.tabRadius ?? 8)),
          child: Text(widget.tabs[i], style: TextStyle(color: currTab == i ? selectColor
              : unselectColor, fontSize:  currTab == i ? selectSize : unselectSize,
              fontWeight: currTab == i && widget.selectBold? FontWeight.bold : FontWeight.normal ),),
          onTap: (){
            setState(() {
              var b = widget.onTabChange(i);
              if(b==true || b==null) currTab = i;
            });
          },
        );
      }, separatorBuilder: (c,i) => SizedBox(width: widget.tabSpace ?? 0,),
          padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
          itemCount: widget.tabs.length, scrollDirection: Axis.horizontal),)
        : Container(height: boxHeight,
      decoration: widget.dividerHeight==0 || widget.dividerColor==null ? null
          : BoxDecoration(border: Border(bottom: BorderSide(color: widget.dividerColor ?? Theme.of(context).dividerColor,
          width: widget.dividerHeight ?? 0
      ))),
      padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
      child: TabBar(
        isScrollable: !widget.tabEqual,
        tabAlignment: widget.tabEqual ? TabAlignment.fill :  TabAlignment.start,
        dividerHeight: 0,
        padding: widget.tabPadding,
        labelPadding: EdgeInsets.symmetric(horizontal: (widget.tabSpace??16)/2),
        indicatorPadding: EdgeInsets.only(top: boxHeight - indHeight),
        indicator: BoxDecoration(color: widget.indicatorColor,
          borderRadius: BorderRadius.circular(widget.indicatorRadius?? 0 ),
          shape: BoxShape.rectangle,
        ),
        indicatorSize: widget.thinIndicator ? TabBarIndicatorSize.label : TabBarIndicatorSize.tab,
        labelColor: widget.selectColor ?? Theme.of(context).primaryColor,
        unselectedLabelColor: widget.unselectColor ?? Theme.of(context).colorScheme.tertiary,
        labelStyle: TextStyle(
            color: widget.selectColor ?? Theme.of(context).primaryColor, fontSize: widget.selectFontSize ?? 16,
            fontWeight: widget.selectBold? FontWeight.bold : FontWeight.normal ),
        unselectedLabelStyle: TextStyle(
            color: widget.unselectColor ?? Theme.of(context).colorScheme.tertiary,
            fontSize: widget.unselectFontSize ?? 16),
        tabs: widget.tabs.map((e) => Tab(text: e,)).toList(),
        onTap: (i) {
          widget.onTabChange(i);
        },
        controller: tabController,
      ),);
  }
}
