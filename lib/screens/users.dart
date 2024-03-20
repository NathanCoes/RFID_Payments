import 'package:flutter/material.dart';
import 'package:rfid_payments/data/dummy_user_data.dart';
import 'package:rfid_payments/widgets/users/user_create.dart';
import 'package:rfid_payments/widgets/users/user_list.dart';
import 'package:rfid_payments/models/user.dart';
import 'package:rfid_payments/widgets/users/user_update.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends State<UserScreen> {
  final _findUserController = TextEditingController();
  
  Widget content = const Text("Oops! No data found.");

  void _openFormNewUser() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewUser(onCreate: _createNewUser),
    );
  }

  void _showUserInfo(Users user){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => UpdateUser(onUpdate: _updateUser, userData: user, onDelete: _deleteUser,),
    );
  }

  void _createNewUser(Users user){
    setState(() {
      userDummy.add(user);
    });
  }

  void _deleteUser(Users user){
    setState(() {
      userDummy.removeWhere((userData) => userData.rif == user.rif);
    });
    Navigator.pop(context);
  }

  void _updateUser(Users user){
    setState(() {
      userDummy.forEach((userData) {
        if (userData.rif == user.rif) {
          userData.banco = user.banco;
          userData.phone = user.phone;
          userData.pin = user.pin;
          print(userData.banco);
        }
      });
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _findUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (userDummy.isNotEmpty){
      content = ListView.builder(
        itemCount: userDummy.length,
        itemBuilder: (ctx, index) => InkWell(
          onTap: (){_showUserInfo(userDummy[index]);},
          splashColor: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(15),
          child: UserCard(userDummy[index])
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 190,
              child: TextField(
                controller: _findUserController,
                decoration: const InputDecoration(labelText: 'Search user'),
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Search")),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 45),
          child: ElevatedButton(
              onPressed: _openFormNewUser, 
              child: const Text("Create a new user")),
        ),
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
