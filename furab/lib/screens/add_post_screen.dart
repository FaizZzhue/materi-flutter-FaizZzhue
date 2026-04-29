import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _base64Image;
  String? _latitude;
  String? _longitude;
  String? _category;
  bool _isSubmitting = false;
  bool _isGettingLocation = false;
  List<String> get categories {
    return [
      'Jalan Rusak',
      'Lampu Jalan Mati',
      'Lawan Arah',
      'Merokok di Jalan',
      'Tidak Pakai Helm',
    ];
  }

  Future<void> _pickImageAndConvert() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  void _showCategorySelect() {
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: categories.map((cat) {
            return ListTile (
              title: Text(cat),
              onTap: () {
                setState(() {
                  _category = cat;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      }
    );
  }

  Widget _buildImagePreview() {
    if (_base64Image == null) {
      return Container(
        height: 180,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: const Text('Belum ada gambar dipilih'),
      );
    }  

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.memory(
        base64Decode(_base64Image!),
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLocationInfo() {
    if(_latitude == null || _longitude == null) {
      return const Text('Lokasi belum diambil');
    }   

    return Text(
      'Lat: $_latitude\nLng: $_longitude',
      textAlign: TextAlign.center,
    );
  }

  Future<void> _submitPost() async {
    if(_base64Image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih gambar terlebih dahulu.'))
      );
    }
    if(_category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih kategori terlebih dahulu.'))
      );
    }
    if(_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan deskripsi terlebih dahulu.'))
      );
    }
    setState(() {
      _isSubmitting = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}