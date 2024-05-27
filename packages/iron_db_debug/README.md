## iron_db_debug

扩展iron_db，增加调试数据功能

## Getting started

```shell
flutter pub add iron_db_debug
```

## Usage

```dart
import 'package:iron_db_debug/iron_db_debug.dart';
final Database db = await Iron.debugAssetsDB();
```

## Additional information

独立出库主要是调试功能要读写项目assets目录在mac端依赖了file_selector,   
这个是iron_db不必要的依赖不应该传递给iron_db的用户，  
不需要的就不要依赖iron_db_debug，  
