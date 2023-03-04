
import 'package:hive/hive.dart';
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

  NotesModal({
    required this.cardnumber,required this.expiry,
    required this.cardholder,required this.cvv
});
 

}