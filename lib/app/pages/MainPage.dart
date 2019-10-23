import 'package:bay_search_books/app/navigations/SlideRightPageRoute.dart';
import 'package:bay_search_books/app/pages/Home.dart';
import 'package:bay_search_books/app/resources/BayColors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool btnEnabled = true;
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final contents = [
      Text('Cari buku yang ingin Anda cari'),
      _searchFormSection(),
      _searchButton(),
    ];

    return WillPopScope(
      onWillPop: _handleBackButton,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: contents
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: item,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final _textInputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Cari',
    hintText: 'Masukkan kata kunci buku',
    helperText: 'Contoh: Harry Potter',
  );

  Widget _searchFormSection() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _searchController,
        onEditingComplete: btnEnabled ? _handleNextPage : null,
        decoration: _textInputDecoration,
        validator: (value) {
          if (value.isEmpty) return 'Pencarian tidak boleh kosong';
          return null;
        },
      ),
    );
  }

  Widget _searchButton() {
    return RaisedButton(
      color: BayColors.blue,
      onPressed: btnEnabled ? _handleNextPage : null,
      child: Text(
        'Cari',
        style: TextStyle(
          color: BayColors.white,
        ),
      ),
    );
  }

  Future<bool> _handleBackButton() async {
    var result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Ingin keluar aplikasi?'),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes')),
          FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No')),
        ],
      ),
    );

    return result == null ? false : result;
  }

  Future _handleNextPage() async {
    if (_formKey.currentState.validate()) {
      _buttonState();
      await Navigator.of(context).push(
        SlideRightPageRoute(
          builder: (context) => Home(searchController: _searchController),
        ),
      );
      _buttonState();
    }
  }

  _buttonState() => setState(() => btnEnabled = !btnEnabled);
}
