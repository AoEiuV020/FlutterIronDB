import 'package:iron_db/iron_db.dart';
// ignore: implementation_imports
import 'package:iron_db/src/iron_impl.dart';

import 'utils_cmd.dart'
    if (dart.library.js_util) 'utils_web.dart'
    if (dart.library.ui) 'utils_flutter.dart';

/// 使用extension添加方法到[Iron]，
/// 这段代码侵入性太强但是没啥好办法，
extension IronDebug on IronInterface {
  /// 用于开发时往assets目录中写入默认数据，
  /// release模式、web端、手机端为只读，只有本机debug时才能写入，
  /// mac端依赖库file_selector需要额外添加，
  Future<Database> debugAssetsDB([String assetsBase = 'assets/IronDB']) {
    return getDebugAssetsDatabase(
        assetsBase, (Iron as IronImpl).dataSerializer);
  }
}
