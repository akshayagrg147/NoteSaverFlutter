import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:exif/exif.dart';

class ImageResizer extends StatefulWidget {
  const ImageResizer({Key? key}) : super(key: key);

  @override
  State<ImageResizer> createState() => _ImageResizerState();
}

class _ImageResizerState extends State<ImageResizer> {
  final picker = ImagePicker();
  XFile? _image;
  File? _imageSelected;
  XFile? _resizedImage;
  double? _width;
  double? _height;
  String _selectedUnit = 'Pixels';

  @override
  void initState() {
    super.initState();
    _selectedUnit = 'Pixels';
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
    if (pickedFile != null) {
      setState(() {
        _imageSelected = File(pickedFile.path);
      });
    }
  }

  Future<double?> _getImageDpi(String imagePath) async {
    final fileBytes = File(imagePath).readAsBytesSync();
    final exifData = await readExifFromBytes(fileBytes);
    if (exifData.containsKey('XResolution') &&
        exifData.containsKey('YResolution')) {
      final xResolution = exifData['XResolution'] as List<dynamic>;
      final yResolution = exifData['YResolution'] as List<dynamic>;
      final xDpi = xResolution.isNotEmpty
          ? (xResolution[0] as int) / (xResolution[1] as int)
          : null;
      final yDpi = yResolution.isNotEmpty
          ? (yResolution[0] as int) / (yResolution[1] as int)
          : null;

      if (xDpi != null && yDpi != null) {
        // Use the average of X and Y DPI values
        return (xDpi + yDpi) / 2;
      }
    }
    return 96.0; // Default DPI value if DPI information is not available
  }

  double _calculateConversionFactor(double dpi) {
    // Calculate conversion factor based on the DPI value
    if (dpi != 96.0) {
      return dpi / 2.54; // DPI to pixels per centimeter conversion factor
    }
    return 37.7952756; // Default conversion factor (96 DPI = 37.7952756 pixels per centimeter)
  }

  void _resizeImage() async {
    if (_image != null && _width != null && _height != null) {
      final image = img.decodeImage(await File(_image!.path).readAsBytes());
      if (image != null) {
        double? dpi = await _getImageDpi(_image!.path);
        double conversionFactor = _calculateConversionFactor(dpi!);
        double widthInPixels = _selectedUnit == 'Centimeters'
            ? _width! * conversionFactor
            : _width!;
        double heightInPixels = _selectedUnit == 'Centimeters'
            ? _height! * conversionFactor
            : _height!;

        final resizedImage = img.copyResize(
          image,
          width: widthInPixels.toInt(),
          height: heightInPixels.toInt(),
        );

        PermissionStatus status = await Permission.storage.request();
        if (status.isGranted) {
          final directory = await getApplicationDocumentsDirectory();
          final resizedImagePath = '${directory.path}/resized_image.jpg';
          final resizedImageFile = File(resizedImagePath);
          await resizedImageFile.writeAsBytes(img.encodeJpg(resizedImage));
          // await GallerySaver.saveImage(resizedImagePath);

          setState(() {
            _image = XFile(resizedImagePath);
            _resizedImage = XFile(resizedImagePath);
          });
        } else {
          log('Permission denied');
        }
      } else {
        log('Failed to decode the image');
      }
    }
  }

  void _shareImage() async {
    if (_resizedImage != null) {
      await Share.shareFiles([_image!.path]);
    }
  }

  void _saveImage() async {
    if (_resizedImage != null) {
      await GallerySaver.saveImage(_image!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Resizer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _image == null
              ? const Text("No Image Selected")
              :SizedBox(
                height: 300,
                width: 200,
                child: Image.file(_imageSelected!),
              ),
              ElevatedButton(
                onPressed: (){
                  _getImageFromGallery();
                  _resizedImage = null;
                },
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 10.0),
              // Text('Selected Image: ${_image?.path ?? 'No Image Selected'}'),
              const SizedBox(height: 10.0),
              DropdownButton<String>(
                value: _selectedUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUnit = newValue!;
                  });
                },
                items: <String>['Pixels', 'Centimeters']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Width'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _width = double.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _height = double.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 10.0),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _resizeImage,
                child: const Text('Resize Image'),
              ),
              const SizedBox(height: 10.0),
              if (_resizedImage != null)
                ElevatedButton(
                  onPressed: _saveImage,
                  child: const Text('Save Image'),
                ),
              if (_resizedImage != null)
                ElevatedButton(
                  onPressed: _shareImage,
                  child: const Text('Share Image'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
