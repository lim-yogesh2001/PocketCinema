class TempTicket {
  final int id;
  final int price;

  TempTicket({
    required this.id,
    required this.price,
  });

  factory TempTicket.fromJson(Map<String, dynamic> json) => TempTicket(
        id: json['id'],
        price: json['price'],
      );
  
  Map<String, dynamic> toJson() => {
    "id" : id,
    "price" : price,
  };
}
