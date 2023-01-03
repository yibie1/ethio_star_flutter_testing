import 'package:ethiostar_testing/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
  final _texte = TextEditingController();
    final _textp = TextEditingController();
  bool _validatee = false;
  bool _validatep = false;

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void dispose() {
    _texte.dispose();
    _textp.dispose();
    super.dispose();
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child:Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.transparent,

                ),
                child:  Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              const CircularProgressIndicator(color: Colors.amber, strokeWidth: 5,),
              SizedBox(width: 8,),
              Text("Loading...."),
             

            ],
          ),
)



        );

      },
    );
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color.fromARGB(255, 10, 113, 209),
            Color.fromARGB(255, 211, 207, 199)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Gap(120),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ),
              Gap(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _texte,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      errorText: _validatee ? 'Email Can\'t Be Empty' : null,
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: null,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 1.5)),
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      labelText: 'Email',
                      hintText: 'Enter  email '),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _textp,
                  onSubmitted: (value) {
                    setState(() {
                      _textp.text.isEmpty ? _validatee = true : _validatee = false;
                       _texte.text.isEmpty ? _validatep = true : _validatep = false;
                    });

                      if((_validatee == false)&& (_validatep == false)){
                          _onLoading();
                      }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomePage()),
                    // );
                  },
                  obscureText: !_showPassword,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      errorText: _validatep ? 'Password Can\'t Be Empty' : null,
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 1.5)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _togglevisibility();
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter  password'),
                ),
              ),
              const Gap(75),
              Container(
                  width: 150,
                  height: 80,
                  child: Image.asset('assets/images/flag.png')),
              const Gap(15),
              const Text(
                'Ethiostars.com',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Gap(80),
              const Text(
                '@copyright Ethiostars 2022, All Right Reserved',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
