import "package:uuid/uuid.dart";
const uuid = Uuid();

class RfidBracelete {
  RfidBracelete ( {
    required this.banco,
    required this.rif,
    required this.phone,
    required this.pin
  } ): id = uuid.v4();

  final String id;
  String banco;
  String rif;
  String phone;
  String pin;
}