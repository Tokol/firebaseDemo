class Khata {
  int id;
  String name;
  String itemName;
  String quantity;
  int rate;
  String date;
  String contact;
  String remarks;

  Khata(
      {this.id,
      this.name,
      this.itemName,
      this.quantity,
      this.rate,
      this.date,
      this.contact,
      this.remarks});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "name": this.name,
      "itemName": this.itemName,
      "quantity": this.quantity,
      "rate": this.rate,
      "date": this.date,
      "contact": this.contact,
      "remarks": this.remarks
    };

    return map;
  }
}
