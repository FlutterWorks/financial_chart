import '../../components/component.dart';
import '../../components/graph/graph.dart';
import '../../components/ticker.dart';
import 'grids_render.dart';
import 'grids_theme.dart';

/// Grid lines
class GGraphGrids extends GGraph<GGraphGridsTheme> {
  static const String typeName = "grids";

  /// The value ticker strategy to decide the grid lines along value axis.
  final GValueTickerStrategy valueTickerStrategy;

  /// The horizontal ticker strategy to decide the grid lines along point axis.
  final GPointTickerStrategy pointTickerStrategy;

  GGraphGrids({
    super.id,
    super.layer,
    super.visible,
    super.valueViewPortId,
    this.valueTickerStrategy = const GValueTickerStrategyDefault(),
    this.pointTickerStrategy = const GPointTickerStrategyDefault(),
    super.hitTestMode = GHitTestMode.none,
    super.overlayMarkers,
    super.theme,
    super.render = const GGraphGridsRender(),
  });

  @override
  String get type => typeName;
}
