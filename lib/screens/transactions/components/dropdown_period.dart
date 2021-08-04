import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../size_config.dart';

class DropdownPeriod<T> extends StatefulWidget {
  final Widget child;
  final void Function(T, int) onChanged;
  final List<DropdownItem<T>> items;
  final bool hideIcon;

  DropdownPeriod({
    Key key,
    this.hideIcon = false,
    @required this.child,
    @required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  _DropdownPeriodState<T> createState() => _DropdownPeriodState<T>();
}

class _DropdownPeriodState<T> extends State<DropdownPeriod<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  AnimationController _animationController;
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Container(
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_currentIndex == -1) ...[
                widget.child,
              ] else ...[
                Row(
                  children: [
                    Text(
                      "Group by ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.items[_currentIndex].text.data,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                // widget.items[_currentIndex],
              ],
              if (!widget.hideIcon)
                RotationTransition(
                  turns: _rotateAnimation,
                  child: SvgPicture.asset(
                    'assets/icons/arrow-drop-down-line.svg',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height + 5),
                  link: this._layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 3,
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenHeight(8)),
                    color: Colors.white,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ListView(
                        padding: EdgeInsets.all(
                          getProportionateScreenHeight(10),
                        ),
                        shrinkWrap: true,
                        children: widget.items.asMap().entries.map((item) {
                          return InkWell(
                            onTap: () {
                              setState(() => _currentIndex = item.key);
                              widget.onChanged(item.value.value, item.key);
                              _toggleDropdown();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(
                                getProportionateScreenHeight(4),
                              ),
                              child: item.value,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      this._overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  final T value;
  final Text text;

  const DropdownItem({Key key, this.value, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return text;
  }
}
