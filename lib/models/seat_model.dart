class SeatModel {
  bool error;
  List<Seat> seat;

  SeatModel({this.error, this.seat});

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    var list = json['seats'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<Seat> bo = list.map((i) => Seat.fromJson(i)).toList();
    return SeatModel(error: json['error'], seat: bo);
  }
}

class Seat {
  int seatNumber;
  String seatName;
  String seatStatus;

  Seat({this.seatNumber, this.seatName, this.seatStatus});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return new Seat(
      seatNumber: json['seat_number'],
      seatName: json['seat_name'],
      seatStatus: json['seat_status'],
    );
  }
}
