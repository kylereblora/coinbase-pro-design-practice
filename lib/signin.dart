import 'package:flutter/material.dart';


/// This screen will display Coinbase's sign in route.
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Map<String, dynamic> values = {};

  void _onChanged(String name, String value) {
    setState(() {
      values[name] = value;
    });
  }

  // The header displayed on the top left area of the screen.
  // Contains a back arrow, and the "Sign in" text.
  Widget _buildSignInHeader() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        Text(
          'Sign in',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // The text fields used in the sign in form.
  // Styled according to coinbase's sign in fields.
  //
  // I simply aggregated the styles here for simplicity, but for larger codebases,
  // I usually set the decorations in a separate file.
  Widget _buildSignInField(
      String hintText, TextInputType keyboardType, String name,
      {bool obscureText = false}) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: (value) => _onChanged(name, value),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white30, fontSize: 20),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white24, style: BorderStyle.solid, width: 0.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white24, style: BorderStyle.solid, width: 0.5),
        ),
      ),
    );
  }

  // Displays the "Sign in" call to action and "Forgot your Password?" sub-action.
  Widget _buildSignInButtonGroup() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            disabledColor: Colors.white38,
            disabledTextColor: Colors.black,
            color: Colors.white,
            onPressed: _allowNext() ? () {} : null,
            child: Text(
              'Sign in',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(height: 18),
        Text(
          'Forgot your password?',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSignInForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            _buildSignInField('Email', TextInputType.emailAddress, 'email'),
            SizedBox(height: 12),
            _buildSignInField('Password', TextInputType.text, 'password',
                obscureText: true),
            SizedBox(height: 36),
            _buildSignInButtonGroup(),
          ],
        ),
      ),
    );
  }

  // Used to set how the Sign in button looks. 
  // 
  // Enabled if the fields are all filled out,
  // disabled if one or none fields are filled out.
  bool _allowNext() {
    if (values.keys.length == 2) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _buildSignInHeader(),
              Spacer(),
              _buildSignInForm(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
