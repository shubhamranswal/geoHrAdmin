import 'package:firebase_database/firebase_database.dart';

class Employee{
  String? key;
  String? UID;
  String? Name;
  String? UUID;
  String? PhoneNumber;
  String? Address;

  Employee(this.UID, this.Name, this.UUID, this.PhoneNumber, this.Address);

  Employee.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    UID = snapshot.value.toString(),
    Name = snapshot.value.toString(),
    PhoneNumber = snapshot.value.toString(),
    Address = snapshot.value.toString();

  toJson() {
    return {
      "UID": UID,
      "Name": Name,
      "UUID": UUID,
      "PhoneNumber": PhoneNumber,
      "Address": Address,
    };
  }
}
