import 'package:cnc_shop/themes/color.dart';
import 'package:cnc_shop/utils/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cnc_shop/widgets/input_decoration.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_btn_widget.dart';

class ResetPaswordScreen extends StatefulWidget {
  const ResetPaswordScreen({super.key});

  @override
  State<ResetPaswordScreen> createState() => _ResetPaswordScreenState();
}

class _ResetPaswordScreenState extends State<ResetPaswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorsPurple,
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage("assets/bg.jpg"),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg', color: kColorsWhite),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: kColorsWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 40, bottom: 20),
              child: Text('Reset password',
                  style: Theme.of(context).textTheme.headline1),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CreateEmail()
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: InkWell(
                    onTap: () {
                      resetPassword();
                    },
                    child: MainBtnWidget(
                        colorBtn: kColorsPurple,
                        textBtn: 'Reset Password',
                        isTransparent: false,
                        haveIcon: false))),
          ]
      )
      )
      )
      
      
    );
  }

  Widget CreateEmail() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: InputDecorationWidget(context, 'Email'),
          controller: emailController,
        ));
  }

  Future resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showSnackBar('Password reset email send !',backgroundColor: Colors.green);
       Navigator.of(context).pop();
    } on FirebaseAuthException catch (e){
      print(e);
      showSnackBar("This email doesn't register yet" , backgroundColor: Colors.red);
    }
    
  }
}