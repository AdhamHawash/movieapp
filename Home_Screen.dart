import 'package:flutter/material.dart';
class ForgetPassword extends StatelessWidget {
  static const Color bg = Colors.black;
  static const Color accent = Color(0xFFF6BD00);
  static const Color fieldBg = Color(0xFF282A28);
  static const Color hint = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.amber),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Forget Password',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/images/Screenshot 2025-09-03 182540.png',
                  height: 430,width: 430,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: fieldBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      color: hint,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(Icons.mail_rounded, color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 55.72,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  child: const Text('Verify Email'),
                ),
              ),
            ],
          ),
        ),
      ),);
  }
}
