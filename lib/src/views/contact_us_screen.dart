import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _preferredCommunication = 'Email';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Your Email',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Your Phone',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'Preferred Method of Communication',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Radio(
                      value: 'Email',
                      groupValue: _preferredCommunication,
                      onChanged: (value) {
                        setState(() {
                          _preferredCommunication = value.toString();
                        });
                      },
                    ),
                    Text('Email'),
                    SizedBox(width: 20.w),
                    Radio(
                      value: 'Phone',
                      groupValue: _preferredCommunication,
                      onChanged: (value) {
                        setState(() {
                          _preferredCommunication = value.toString();
                        });
                      },
                    ),
                    Text('Phone'),
                  ],
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),
                  minLines: 1,
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Add logic to handle form submission
                      String name = _nameController.text;
                      String email = _emailController.text;
                      String phone = _phoneController.text;
                      String preferredCommunication = _preferredCommunication;
                      String message = _messageController.text;

                      // Perform actions with the form data
                      print('Name: $name, Email: $email, Phone: $phone, Preferred Communication: $preferredCommunication, Message: $message');
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
