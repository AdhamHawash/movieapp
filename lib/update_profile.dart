// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController =
  TextEditingController(text: "John Safwat");
  TextEditingController phoneController =
  TextEditingController(text: "01200000000");

  String selectedAvatar = "assets/images/avatar8.png"; // default avatar

  // Function to show avatar picker bottom sheet
  void _showAvatarPicker() {
    List<String> avatars = [
      "assets/images/avatar1.png",
      "assets/images/avatar2.png",
      "assets/images/avatar3.png",
      "assets/images/avatar4.png",
      "assets/images/avatar5.png",
      "assets/images/avatar6.png",
      "assets/images/avatar7.png",
      "assets/images/avatar8.png",
      "assets/images/avatar9.png",
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff282A28),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatars[index];
                  });
                  Navigator.pop(context); // Close bottom sheet
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: selectedAvatar == avatars[index]
                        ? const Color(0xffF6BD00).withOpacity(0.56) //
                        : Colors.transparent,
                    border: Border.all(
                      color: const Color(0xffF6BD00),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      avatars[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },

          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Pick Avatar",
          style: TextStyle(color: Color(0xffF6BD00), fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _showAvatarPicker,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(selectedAvatar),
                backgroundColor: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),

            // Name field
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Phone field
            TextField(
              controller: phoneController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Reset password action
                },
                child: const Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const Spacer(),

            // Delete account button
            ElevatedButton(
              onPressed: () {
                // Delete account action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffE82626),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Delete Account",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 15),

            // Update data button
            ElevatedButton(
              onPressed: () {
                // Save updated data (name, phone, avatar, etc.)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Update Data",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
