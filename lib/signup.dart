import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // A focus node to listen to which form field is currently focused.
  // Will be used to style the labels of the form fields.
  FocusNode _focusNodeFirstName = new FocusNode();
  FocusNode _focusNodeLastName = new FocusNode();
  FocusNode _focusNodeEmail = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();

  // An object to store the form values
  Map<String, dynamic> values = {};

  // A boolean to determine if a specific form field is currently focused.
  bool _isFocused;
  bool _agrees;

  @override
  void initState() {
    super.initState();
    _agrees = false;
    _isFocused = false;
    _focusNodeFirstName.addListener(_onFocusChanged);
    _focusNodeLastName.addListener(_onFocusChanged);
    _focusNodeEmail.addListener(_onFocusChanged);
    _focusNodePassword.addListener(_onFocusChanged);
  }

  // Set the value if focus has changed
  void _onFocusChanged() {
    setState(() {
      _isFocused = !_isFocused;
    });
  }

  void _onChanged(String name, String value) {
    setState(() {
      values[name] = value;
    });
  }

  void _onCheckboxToggle(String name, bool value) {
    setState(() {
      _agrees = value;
      values[name] = value;
    });
  }

  bool _allowNext() {
    if (values.values.length == 5) {
      return true;
    }
    return false;
  }

  Widget _buildSignUpField(String labelText, String hintText,
      TextInputType keyboardType, String name, FocusNode focusNode,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: focusNode.hasFocus ? Color(0xFF3232ff) : Colors.black),
        ),
        SizedBox(height: 5),
        TextFormField(
          focusNode: focusNode,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: (value) => _onChanged(name, value),
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black38),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: values[name] != null && values[name] != ''
                    ? Colors.grey.withOpacity(0.15)
                    : Colors.transparent,
                style: BorderStyle.solid,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFF3232ff), style: BorderStyle.solid, width: 2),
            ),
            filled: values[name] != null && values[name] != '' ? false : true,
          ),
        )
      ],
    );
  }

  Widget _buildFirstNameField() {
    return _buildSignUpField('First Name', 'First Name', TextInputType.text,
        'firstName', _focusNodeFirstName);
  }

  Widget _buildLastNameField() {
    return _buildSignUpField('Last Name', 'Last Name', TextInputType.text,
        'lastName', _focusNodeLastName);
  }

  Widget _buildEmailField() {
    return _buildSignUpField('Email address', 'Email address',
        TextInputType.text, 'emailAddress', _focusNodeEmail);
  }

  Widget _buildPasswordField() {
    return _buildSignUpField('Password', 'Minimum 8 characters',
        TextInputType.text, 'password', _focusNodePassword,
        obscureText: true);
  }

  Widget _buildCheckbox(String name, bool boolValue) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                checkColor: Color(0xFF3232ff),
                activeColor: Colors.white,
                value: boolValue,
                onChanged: (bool value) {
                  _onCheckboxToggle(name, value);
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 5,
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                    children: <InlineSpan>[
                      TextSpan(
                          text:
                              'I certify that I am 18 years of age or older, and I agree to the '),
                      TextSpan(
                        text: 'User Agreement ',
                        style: TextStyle(
                          color: Color(0xFF3232ff).withOpacity(0.7),
                        ),
                      ),
                      TextSpan(text: 'and '),
                      TextSpan(
                        text: 'Privacy policy. ',
                        style: TextStyle(
                          color: Color(0xFF3232ff).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildFirstNameField(),
          SizedBox(height: 18),
          _buildLastNameField(),
          SizedBox(height: 18),
          _buildEmailField(),
          SizedBox(height: 18),
          _buildPasswordField(),
          SizedBox(height: 18),
          _buildCheckbox('agrees', _agrees),
          Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
                onPressed: _allowNext() ? () {} : null,
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                disabledColor: Color(0xFF3232ff).withOpacity(0.6)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'Create your account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Expanded(child: _buildSignUpForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
