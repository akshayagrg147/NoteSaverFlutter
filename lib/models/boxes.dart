
import 'package:cardsaver/models/notes_modal.dart';
import 'package:hive/hive.dart';

class Boxes{
  static Box<NotesModal> getdata()=>Hive.box<NotesModal>("notes");
  static Box<SocialModal> getSocialPasswords()=>Hive.box<SocialModal>("socialPasswords");
  static Box<SocialModal> getFacebookPasswords()=>Hive.box<SocialModal>("facebookPasswords");
  static Box<SocialModal> getInstagramPasswords()=>Hive.box<SocialModal>("instagramPasswords");
  static Box<SocialModal> getgooglePasswords()=>Hive.box<SocialModal>("googlePasswords");
  static Box<SocialModal> getBankingPasswords()=>Hive.box<SocialModal>("internetBanking");
  static Box<ProfileInfoModal> getprofiledata()=>Hive.box<ProfileInfoModal>("profileinfo");

  static Box<DocumentModal> getpan()=>Hive.box<DocumentModal>("pan");
  static Box<DocumentModal> getaadhaar()=>Hive.box<DocumentModal>("aadhaar");
  static Box<DocumentModal> getlicense()=>Hive.box<DocumentModal>("license");
  static Box<DocumentModal> gethsc()=>Hive.box<DocumentModal>("hsc");
  static Box<DocumentModal> getssc()=>Hive.box<DocumentModal>("ssc");
  static Box<DocumentModal> getother()=>Hive.box<DocumentModal>("other");


  // static Box<TransactionModal> gettransactiondata()=>Hive.box<TransactionModal>("Add");



  // static Box<CategoryModal> getCategoryModal()=>Hive.box<CategoryModal>("category");
}

