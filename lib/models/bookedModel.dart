import 'dart:convert';

class BookModel {
  bool error;
  String message;
  List<Booked> booked;
  Booked mBooked;

  BookModel({this.error, this.message, this.booked, this.mBooked});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    var list = json['reservation'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<Booked> bo = list.map((i) => Booked.fromJson(i)).toList();
    return BookModel(
        error: json['error'], message: json['message'], booked: bo);
  }

  static List<Booked> parseBooked(imagesJson) {
    var list = imagesJson['reservation'] as List;
    List<Booked> seats = list.map((data) => Booked.fromJson(data)).toList();
    return seats;
  }
}

class Booked {
  int reservationId;
  String userId;
  int serviceId;
  String reservationStatus;
  int seatNo;
  String createdAt;
  String serviceType;
  String service;
  String startHour;
  String endHour;
  int availableSeats;
  String seats;

  Booked(
      {this.reservationId,
      this.userId,
      this.serviceId,
      this.reservationStatus,
      this.seatNo,
      this.createdAt,
      this.serviceType,
      this.startHour,
      this.endHour,
      this.availableSeats,
      this.service,
      this.seats});

  factory Booked.fromJson(Map<String, dynamic> json) {
    return new Booked(
      reservationId: json['reservation_id'],
      userId: json['user_id'],
      serviceId: json['service_id'],
      reservationStatus: json['reservation_status'],
      seatNo: json['seats_number'],
      createdAt: json['created_at'],
      serviceType: json['service_type'],
      service: json['service'],
      startHour: json['start_hours'],
      endHour: json['end_hours'],
      seats: json['seats'],
      availableSeats: json['available_seats'],
    );
  }

  Map<String, dynamic> toJson() => {
        "reservation_id": reservationId,
        "user_id": userId,
        "service_id": serviceId,
        "reservation_status": reservationId,
        "seats_number": seatNo,
        "created_at": createdAt,
        "service_type": serviceType,
        "start_hours": startHour,
        "end_hours": endHour,
        "available_seats": availableSeats
      };
}
