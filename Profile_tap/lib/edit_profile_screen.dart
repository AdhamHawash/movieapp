import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'avatar_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final File? currentImage;
  final String? currentAvatar;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentPhone,
    this.currentImage,
    this.currentAvatar,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  File? newImage;
  String? newAvatar;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    phoneController = TextEditingController(text: widget.currentPhone);
    newImage = widget.currentImage;
    newAvatar = widget.currentAvatar;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.amber),
              title: const Text("Choose from Gallery", style: TextStyle(color: Colors.white)),
              onTap: () async {
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) setState(() => newImage = File(pickedFile.path));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.amber),
              title: const Text("Take Photo", style: TextStyle(color: Colors.white)),
              onTap: () async {
                final pickedFile = await picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) setState(() => newImage = File(pickedFile.path));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.amber),
              title: const Text("Choose Avatar", style: TextStyle(color: Colors.white)),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AvatarScreen()));
                if (result != null && result is String) setState(() { newAvatar = result; newImage = null; });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = newImage != null
        ? FileImage(newImage!)
        : newAvatar != null
        ? AssetImage(newAvatar!)
        : const AssetImage("assets/images/default.png");

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.amber), onPressed: () => Navigator.pop(context)),
        title: const Text("Edit Profile", style: TextStyle(color: Colors.amber)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imageProvider,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: phoneController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    title: const Text(
                      "Confirm Delete",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      "Are you sure you want to delete your account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel", style: TextStyle(color: Colors.amber)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Delete", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                if (confirm) {
                  Navigator.pop(context, null);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "name": nameController.text,
                  "phone": phoneController.text,
                  "image": newImage,
                  "avatar": newAvatar,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Update Data",
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
