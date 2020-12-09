
import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  User({this.email,this.password, this.name, this.id});


  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;

  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;


  // buscando o id do usuario
DocumentReference get firesToreRef =>
    Firestore.instance.document('users/$id');


// salvando os dados do user na base de dados
Future<void> saveData() async{
  await firesToreRef.setData(toMap());
}

//
Map <String, dynamic> toMap(){
  return {
    'name':name,
    'email':email,
  };

}


}