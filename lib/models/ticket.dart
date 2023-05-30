class Ticket {
  final int id;
  final String transectionCode;
  final bool status;
  final int ticketId;
  final int reserveSeatId;

  Ticket(
      {required this.id,
      required this.transectionCode,
      required this.status,
      required this.ticketId,
      required this.reserveSeatId});

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json['id'],
        transectionCode: json['transection_code'],
        status: json['status'],
        ticketId: json['ticket_id'],
        reserveSeatId: json['reserved_seat_id'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'transection_code': transectionCode,
    'status': status,
    'ticket_id': ticketId,
    'reserved_seat_id': reserveSeatId,
  };
}
