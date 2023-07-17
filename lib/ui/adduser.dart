import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geo_attendance_system_hr/constants/colors.dart';
import 'package:geo_attendance_system_hr/models/employee.dart';
import 'package:geo_attendance_system_hr/services/authentication.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUSerState createState() => _AddUSerState();
}

class _AddUSerState extends State<AddUser> {
  final _formKey = new GlobalKey<FormState>();
  String? key, UID, Name, UUID, PhoneNumber, Address, email, password;

  DatabaseReference _userRef = FirebaseDatabase.instance.ref().child('users');
  DatabaseReference _employeeIDRef =
      FirebaseDatabase.instance.ref().child('EmployeeID');

  String? _errorMessage;

  Auth authObject = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 50,),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Employee ID",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) {
                      String? ret;
                      ret =
                          value!.isEmpty ? 'Employee ID can\'t be empty' : null;
                      try {
                        int.parse(value);
                      } catch (e) {
                        ret = "Enter numeric value only";
                      }
                      return ret;
                    },
                    onSaved: (value) => UID = value,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Name can\'t be empty' : null,
                    onSaved: (value) => Name = value!,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => email = value!,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Password can\'t be empty' : null,
                    onSaved: (value) => password = value!,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "UUID",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'UUID can\'t be empty' : null,
                    onSaved: (value) => UUID = value!,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) {
                      String? ret;
                      ret = value!.isEmpty
                          ? 'Phone Number can\'t be empty'
                          : null;

                      if (value.length != 10)
                        ret = "Enter 10-digit phone number";

                      return ret;
                    },
                    onSaved: (value) => PhoneNumber = value!,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Address",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Address can\'t be empty' : null,
                    onSaved: (value) => Address = value!,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                      _errorMessage == null ? "" : _errorMessage.toString()),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Center(
                        child: MaterialButton(
                      child: Text("Add Employee",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () => validateEmployee(context),
                      color: leaveCardcolor,
                    ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Center(
                        child: MaterialButton(
                      child: Text("Reset Form",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _errorMessage = "";
                        _formKey.currentState!.reset();
                      },
                      color: Colors.red,
                    )))
              ],
            )),
      ),
    );
  }

  void validateEmployee(context) {
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      Employee employee = Employee(this.UID.toString(), this.Name, this.UUID,
          this.PhoneNumber, this.Address);
      try {
        print("in try");
        authObject
            .signUp(email.toString(), password.toString())
            .then((Map<int, String> value) {
          print(value.keys.first);

          if (value.keys.first == 0) {
            _userRef.child(value[0]!).set(employee.toJson());
            _employeeIDRef.child(this.UID.toString()).set(this.email);

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("User Added Successfully"),
                    content: Text(
                        "User can start using his account through his employee ID and password."),
                  );
                });
            _formKey.currentState!.reset();
          } else {
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Some Error Occured"),
                      content: value[1] != null ? Text(value[1]!) : Text(" "),
                    );
                  });
            });
          }
        });
      } catch (e) {
        print("in catch");
      }
    }
  }
}
