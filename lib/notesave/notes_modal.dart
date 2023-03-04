
import 'package:hive/hive.dart';
part 'notes_modal.g.dart';

@HiveType(typeId: 0)
class NotesModal extends HiveObject{
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String description;

  NotesModal({
    required this.title,required this.description
});
 

}