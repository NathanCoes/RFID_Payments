import "package:uuid/uuid.dart";
const uuid = Uuid();

class RfidPos {
  RfidPos ( {
    required this.numero,
    required this.sucursal,
    required this.userId,
    required this.estatus
  } ): id = uuid.v4();

  final String id;
  String numero;
  String sucursal;
  String userId;
  bool estatus;
}