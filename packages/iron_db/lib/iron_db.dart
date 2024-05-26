library iron_db;

import 'iron_db.dart';
import 'src/iron_impl.dart';

export 'src/iron_interface.dart';
export 'src/database.dart';
export 'src/serialize.dart';

// ignore: non_constant_identifier_names
final IronInterface Iron = IronImpl();
