import "package:uuid/uuid.dart";
const uuid = Uuid();

class RfidTransactions {
  RfidTransactions ( {
    required this.encryptedData,
    required this.fechaEncriptacion,
    required this.monto,
    required this.pin,
    required this.postId
  } ): id = uuid.v4();

  final String id;
  String encryptedData;
  String fechaEncriptacion;
  String monto;
  String pin;
  String postId;
}