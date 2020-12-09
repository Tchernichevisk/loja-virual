import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();

  }

final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  User user;

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggenIn => user != null;


  // criando Login no firebase
  Future<void> signIn ({User user, Function onFail, Function onSuccess}) async{
  loading = true;
    try{
    final AuthResult result = await auth.signInWithEmailAndPassword(
    email: user.email, password: user.password);

    await _loadCurrentUser(firebaseUser: result.user);

    onSuccess();

  } on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

// criando cadastro no firebase
  Future<void>signUp({User user, Function onFail, Function onSuccess}) async{
loading = true;
try {
  //pegando o id do objecto
  final AuthResult result = await auth.createUserWithEmailAndPassword(
      email: user.email, password: user.password);

//salvando o id no user
    user.id = result.user.uid;
this.user = user;

  await user.saveData();

  onSuccess();

} on PlatformException catch(e){

  onFail(getErrorString(e.code));

}
loading = false;
  }

void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();

}




  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future <void> _loadCurrentUser({FirebaseUser firebaseUser}) async{
   final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
   if(currentUser != null){

     // acessando a coleccao user, pegando o id do usuario e dou um get para obter o documento
final DocumentSnapshot docUser = await firestore.collection('users')
    .document(currentUser.uid).get();

    user = User.fromDocument(docUser);
  print (user.name);
    notifyListeners();
   }

  }


}