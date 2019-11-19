import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _password_text = new TextEditingController();
  final TextEditingController _text_area = new TextEditingController();
  final TextEditingController _text_area_reply_forum = new TextEditingController();

  //Password
  // Initially password is obscure
  bool _obscureText = true;

  String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
//                labelText: 'Email',
                hintText: 'Email',
                filled: true,
//                  prefixIcon: Icon(
//                    Icons.account_box,
//                    size: 28.0,
//                  ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    }),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              validator: (val) => val.length < 6 ? 'Password too short.' : null,
              onSaved: (val) => _password = val,
              obscureText: _obscureText,
              controller: _password_text,
              decoration: InputDecoration(
                hintText: 'Password',
//                labelText: 'Password',
                filled: true,
//                  prefixIcon: Icon(
//                    Icons.account_box,
//                    size: 28.0,
//                  ),

                suffixIcon: IconButton(
                    icon: new Icon(_obscureText
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye),
                    onPressed: () {
                      _toggle();
                    }),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              maxLength: 25,
              validator: (val) => val.length < 25 ? 'Text too short.' : null,
              controller: _text_area,
              decoration: InputDecoration(
//                hintText: 'Password',
                labelText: 'Add Comment',
                filled: true,


              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              maxLength: 25,
              validator: (val) => val.length < 25 ? 'Text too short.' : null,
              controller: _text_area_reply_forum,
              decoration: InputDecoration(
//                hintText: 'Password',
                labelText: 'Reply Forum',
                filled: true,


              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: BasicDateField(),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: BasicTimeField(),
          ),
//          SubmitReview(),
        ],
      ),
    );
  }
}

class SubmitReview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child:TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        maxLength: 160,
        validator: (val) => val.length < 25 ? 'Text too short.' : null,

        decoration: InputDecoration(
//                hintText: 'Password',
          labelText: 'Submit Review',
          filled: true,
        ),

      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        'Date (${format.pattern})',
      ),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
          'Time (${format.pattern})'
      ),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}