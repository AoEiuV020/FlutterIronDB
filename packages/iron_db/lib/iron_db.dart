library iron_db;

import 'iron_db.dart';
import 'src/iron_impl.dart';

export 'src/iron_interface.dart';
export 'src/database.dart';
export 'src/serialize.dart';

/// 入口对象，本库的核心对象，可以通过 [Iron] 创建 [Database] 对象,
// ignore: non_constant_identifier_names
final IronInterface Iron = IronImpl();
