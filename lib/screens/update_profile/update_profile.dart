// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/screens/login/login_screen.dart';
import 'package:movieapp/screens/reset_password/reset_password.dart';
import 'package:movieapp/screens/update_profile/update_profile_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "updateProfile";

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UpdateProfileViewModel viewModel = UpdateProfileViewModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int? selectedAvatar;

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

  // Function to show avatar picker bottom sheet
  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff282A28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0.w),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatars.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = index;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color:
                        selectedAvatar == index
                            ? Color(0xffF6BD00).withOpacity(0.56) //
                            : Colors.transparent,
                    border: Border.all(
                      color: const Color(0xffF6BD00),
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(avatars[index], fit: BoxFit.cover),
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
    return BlocProvider(
      create: (context) => viewModel..getProfile(),
      child: BlocListener<UpdateProfileViewModel, States>(
        listener: (context, state) {
          if (state is LoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16.w),
                        Text("Loading..."),
                      ],
                    ),
                  ),
            );
          }
          if (state is ErrorState) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => AlertDialog(
                    title: Text("Error"),
                    content: Text(state.message),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
            );
          }
          if (state is SucessState) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            setState(() {
              nameController.text = viewModel.profile?.name ?? "";
              phoneController.text = viewModel.profile?.phone ?? "";
              selectedAvatar = viewModel.profile?.avaterId ?? 0;
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Pick Avatar",
              style: TextStyle(color: Color(0xffF6BD00), fontSize: 16.sp),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _showAvatarPicker,
                  child: CircleAvatar(
                    radius: 60.r,
                    backgroundImage: AssetImage(avatars[selectedAvatar ?? 0]),
                    backgroundColor: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 20.h),
                // Name field
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),

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
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ResetPassword.routeName);
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                Spacer(),

                // Delete account button
                ElevatedButton(
                  onPressed: () {
                    viewModel.deleteAccount();
                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffE82626),
                    minimumSize: Size(double.infinity, 50.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Delete Account",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                SizedBox(height: 15.h),

                // Update data button
                ElevatedButton(
                  onPressed: () {
                    viewModel.updateData(
                      nameController.text,
                      phoneController.text,
                      selectedAvatar as int,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: Size(double.infinity, 50.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Update Data",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
