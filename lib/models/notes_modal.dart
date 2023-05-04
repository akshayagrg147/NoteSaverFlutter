
import 'package:hive/hive.dart';
import 'dart:io';
part 'notes_modal.g.dart';


@HiveType(typeId: 0)
class NotesModal extends HiveObject{
  @HiveField(0)
  late String cardnumber;
  @HiveField(1)
  late String expiry;
  @HiveField(2)
  late String cardholder;
  @HiveField(3)
  late String cvv;
  @HiveField(4)
  late String bankname;
  @HiveField(5)
  late int? color;
  @HiveField(5)
  late String? cardtype;



  NotesModal({
    required this.cardnumber,required this.expiry,
    required this.cardholder,required this.cvv,
    required this.bankname,
    required this.color,
    required this.cardtype,
});
 

}
@HiveType(typeId: 1)
class SocialModal extends HiveObject{
  @HiveField(0)
  late String username;
  @HiveField(1)
  late String password;
  @HiveField(2)
  late String? title;
  @HiveField(3)
  late String? icon;



  SocialModal({
    required this.username,required this.password,
    required this.title, required this.icon
  });
}

@HiveType(typeId: 2)
class ProfileInfoModal extends HiveObject{
  @HiveField(0)
  late String firstname;
  @HiveField(1)
  late String lastname;
  @HiveField(2)
  late String email;
  @HiveField(3)
  late String gender;
  @HiveField(4)
  late File? image;

  ProfileInfoModal({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.gender,
    required this.image,
  });

}

