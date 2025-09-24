// Superclass (Base class)
class BaseOrder {
  final String service;
  final DateTime date;
  

  BaseOrder({
    required this.service,
    required this.date,
  });

  String getOrderInfo() {
    return 'Service: $service, Date: $date';
  }
}

// Specialized Order Types
class RideOrder extends BaseOrder {
  final int passengerCount;
  final String vehicleType;

  RideOrder({
    required String service,
    required DateTime date,
    required this.passengerCount,
    this.vehicleType = 'Motor',
  }) : super(
          service: service,
          date: date,
        );

  @override
  String getOrderInfo() {
    return """
    ${super.getOrderInfo()}
    Jumlah Penumpang: $passengerCount
    Kendaraan: $vehicleType
    """;
  }
}

class DeliveryOrder extends BaseOrder {
  final String itemName;
  final double itemWeight;
  final bool isFragile;

  DeliveryOrder({
    required String service,
    required DateTime date,
    required this.itemName,
    this.itemWeight = 0.0,
    this.isFragile = false,
  }) : super(
          service: service,
          date: date,
        );

  @override
  String getOrderInfo() {
    return """
    ${super.getOrderInfo()}
    Barang: $itemName
    Berat: ${itemWeight}kg
    Mudah Pecah: ${isFragile ? 'Ya' : 'Tidak'}
    """;
  }
}

class SurveyOrder extends BaseOrder {
  final String kostType;
  final bool withPhotos;
  final double budget;

  SurveyOrder({
    required String service,
    required DateTime date,
    required this.kostType,
    required this.budget,
    this.withPhotos = true,
  }) : super(
          service: service,
          date: date,
        );

  @override
  String getOrderInfo() {
    return """
    ${super.getOrderInfo()}
    Tipe Kost: $kostType
    Budget: Rp$budget
    Dengan Foto: ${withPhotos ? 'Ya' : 'Tidak'}
    """;
  }
}

class Order extends BaseOrder {
  String _status = 'pending';

  Order({
    required String service,
    required DateTime date,
  }) : super(
          service: service,
          date: date,
        );

  String get status => _status;
  set status(String value) => _status = value;
}