import 'dart:io';
import 'package:cardsaver/models/notes_modal.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cardsaver/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../Utils/notes_widgets/select_photo_bottom_sheet.dart';
import 'package:printing/printing.dart';

import '../models/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';




class SaveDocument extends StatefulWidget {
  const SaveDocument({Key? key}) : super(key: key);

  @override
  State<SaveDocument> createState() => _SaveDocumentState();
}

class _SaveDocumentState extends State<SaveDocument> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "Document",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFf4f4f4),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(Icons.home)),
        ],
      ),
      body:
      Column(
        // file: file
        children: [
          NewListTile(title: "AadharCard",icon: "assets/images/aadhaar.png",pages: 2,),
          NewListTile(title: "Pan Card",icon: "assets/images/PanCard.png",),
          NewListTile(title: "Driving License",icon: "assets/images/Driving.png",),
          NewListTile(title: "HSC Marksheet",icon: "assets/images/Marksheet.png",),
          NewListTile(title: "SSC Marksheet", icon: "assets/images/Marksheet.png",),
          NewListTile(title: "Other",icon: "assets/images/document.png",),
        ],
      ),
    );
  }
  }


// ignore: must_be_immutable
class NewListTile extends StatefulWidget {
  NewListTile({
    super.key,
    required this.title,
    required this.icon,
    this.pages = 1,
  });

  File? file;
  File? file2;
  final String title;
  final String icon;
  int pages;

  @override
  State<NewListTile> createState() => _NewListTileState();
}

class _NewListTileState extends State<NewListTile> {

  @override
  Widget build(BuildContext context) {
    var listenable = Boxes.getaadhaar().listenable();
    if (widget.title.contains('Pan')) {
      listenable = Boxes.getpan().listenable();
    } else if (widget.title.contains('Driving')) {
      listenable = Boxes.getlicense().listenable();
    }else if (widget.title.contains('HSC')) {
      listenable = Boxes.gethsc().listenable();
    }else if (widget.title.contains('SSC')) {
      listenable = Boxes.getssc().listenable();
    }else if (widget.title.contains('Other')) {
      listenable = Boxes.getother().listenable();
    }
    return ValueListenableBuilder(
        valueListenable: listenable,
        builder: (context, box, _) {
      var data = box.values.toList().cast<DocumentModal>();
      if (box.length != 0){
          widget.file = File(data[0].name!);
          if(widget.pages == 2){
            widget.file2 = File(data[1].name!);
          }
      }


      return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.icon),
          radius: 20,
          backgroundColor: Colors.white,
        ),
        title: Text(widget.title + box.length.toString()),

        subtitle: widget.file == null ?Text("Upload ${widget.title}") : const Text("Uploaded"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  _showSelectPhotoOptions(context);
                },
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.black26,
                )),
            IconButton(
                onPressed: () async {
                  if(widget.file != null){
                    if(widget.pages ==2){
                      _generatePdf(file:widget.file, file2:widget.file2);
                    }else{_generatePdf(file:widget.file);
                    }
                  }
                  else{
                    noFileSelectedNotification();
                  }
                },
                icon: const Icon(
                  LineAwesomeIcons.download,
                  color: Colors.black26,
                )),
            IconButton(
                onPressed: () {
                  if(widget.file != null){
                    _sharePdf(widget.file);
                  }
                  else{
                    noFileSelectedNotification();
                  }
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.black26,
                )),
          ],
        ),
        onLongPress: () async {},
        onTap: () async {},
      );

    });
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImages,
              ),
            );
          }),
    );
  }

  Future _pickImages(ImageSource source) async {
    final navigator = Navigator.of(context);
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      String? imgs = await _cropImage(imageFile: img);
      // setState(() {
      //   widget.file = File(imgs!);
      //   Navigator.of(context).pop();
      // });
      var data = DocumentModal(name: imgs);
      var box = Boxes.getaadhaar();
      if (widget.title.contains('Pan')) {
        box = Boxes.getpan();
      } else if (widget.title.contains('Driving')) {
        box = Boxes.getlicense();
      }else if (widget.title.contains('HSC')) {
        box = Boxes.gethsc();
      }else if (widget.title.contains('SSC')) {
        box = Boxes.getssc();
      }else if (widget.title.contains('Other')) {
        box = Boxes.getother();
      }
      if(box.length == 0){box.add(data);}
      else{box.putAt(0,data);}
      navigator.pop();

    } on PlatformException catch (e) {
      Navigator.of(context).pop();
      return e;
    }
    if(widget.pages ==2){
      try {
        final image1 = await ImagePicker().pickImage(source: source);
        if (image1 == null) return;
        File? img1 = File(image1.path);
        String? imgs1 = await _cropImage(imageFile: img1);
        var data = DocumentModal(name: imgs1);
        var box = Boxes.getaadhaar();
        if(box.length < 2){
          box.add(data);
        }
        else{
          box.putAt(1,data);
        }
      } on PlatformException catch (e) {
        navigator.pop();
        return e;
      }
    }
  }


  void _generatePdf({required file, file2,}) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final showImage = pw.MemoryImage(file.readAsBytesSync());

    pdf.addPage(
      pw.Page(
        pageFormat:PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.Image(showImage, fit: pw.BoxFit.contain),
          );
        },
      ),
    );
    if(widget.pages ==2){
      final showImage2 = pw.MemoryImage(file2.readAsBytesSync());
      pdf.addPage(
        pw.Page(
          pageFormat:PdfPageFormat.a4,
          build: (context) {
            return pw.Center(
              child: pw.Image(showImage2, fit: pw.BoxFit.contain),
            );
          },
        ),
      );
    }

    // return pdf.save();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
  void _sharePdf(file) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final showImage = pw.MemoryImage(file.readAsBytesSync());

    pdf.addPage(
      pw.Page(
        pageFormat:PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.Image(showImage, fit: pw.BoxFit.contain),
          );
        },
      ),
    );

    // return pdf.save();
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'document.pdf');
  }

  void noFileSelectedNotification(){
    Fluttertoast.showToast(
        msg:
        "No document Uploaded",
        toastLength:
        Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor:
        Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<String?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    // return File(croppedImage.path);
    return croppedImage.path;
  }
}
