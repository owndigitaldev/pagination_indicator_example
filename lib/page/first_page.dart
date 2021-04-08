import 'package:flutter/material.dart';
import 'package:pagination_example/common/constans.dart';
import 'package:pagination_example/common/styles.dart';
import 'package:pagination_example/dialog/exit_dialog.dart';
import 'package:pagination_example/page/second_page.dart';
import 'package:pagination_example/tool/helper.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Helper _helper;

  int _completePage;
  int _currentPage;

  //page 1
  GlobalKey<FormState> _formKey1;
  TextEditingController _cNama;
  TextEditingController _cNim;

  //page 2
  GlobalKey<FormState> _formKey2;
  int _option2;
  TextEditingController _lipsum;

  //page 3
  int _option31;
  int _option32;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _helper = new Helper();
    _completePage = 0;
    _currentPage = 1;
    _formKey1 = new GlobalKey();
    _cNama = new TextEditingController();
    _cNim = new TextEditingController();
    _formKey2 = new GlobalKey();
    _lipsum = new TextEditingController();
  }

  Future<bool> _onWillPop() async {
    return await openExitDialog(context) ?? false;
  }

  void _onIndicatorTapped(int i) {
    if (i <= _completePage) {
      setState(() {
        _currentPage = i;
      });
    }
  }

  void _onNext() {
    switch (_currentPage) {
      case 1:
        if (_formKey1.currentState.validate()) {
          _toNextPage();
        } else {
          _helper.showSnackbar(_scaffoldKey, "Harap Isi Semua Data!");
        }
        break;
      case 2:
        if (_option2 == null) {
          _helper.showSnackbar(_scaffoldKey, "Harap Isi Pilihan!");
        } else {
          if (_formKey2.currentState.validate()) {
            _toNextPage();
          } else {
            _helper.showSnackbar(_scaffoldKey, "Harap Isi Semua Data!");
          }
        }
        break;
      case 3:
        if (_option31 == null || _option32 == null) {
          _helper.showSnackbar(_scaffoldKey, "Harap Isi Pilihan!");
        } else {
          _helper.jumpToPage(context, page: SecondPage());
        }
        break;
    }
  }

  void _toNextPage() {
    setState(() {
      _completePage = _currentPage + 1;
      _currentPage++;
    });
  }

  void _onPrev() {
    setState(() {
      _completePage = _currentPage - 1;
      _currentPage--;
    });
  }

  String _validator(String s) {
    return s.isEmpty ? "Kolom wajib diisi!" : null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("Pagination Example")),
        body: _buildBody(),
      ),
      onWillPop: _onWillPop,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                _indicator(1),
                _divider(1),
                _indicator(2),
                _divider(2),
                _indicator(3),
              ],
            ),
            SizedBox(height: 64.0),
            if (_currentPage == 1) _page1(),
            if (_currentPage == 2) _page2(),
            if (_currentPage == 3) _page3(),
          ],
        ),
      ),
    );
  }

  Widget _indicator(int page) {
    return InkWell(
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: _currentPage >= page ? hPrimary : hSecondary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "$page",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () => _onIndicatorTapped(page),
    );
  }

  Widget _divider(int page) {
    return Expanded(
      child: Divider(
        color: _completePage > page ? hPrimary : hSecondary,
        thickness: 4.0,
      ),
    );
  }

  Widget _page1() {
    return Column(
      children: [
        Form(
          key: _formKey1,
          child: Column(
            children: [
              TextFormField(
                controller: _cNama,
                keyboardType: TextInputType.name,
                validator: _validator,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Jhonny Berdosa',
                  labelText: 'Nama',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cNim,
                keyboardType: TextInputType.text,
                validator: _validator,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: '69420666',
                  labelText: 'Nim',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0),
        _button(
          title: "Selanjutnya",
          onTap: _onNext,
        ),
      ],
    );
  }

  Widget _page2() {
    return Column(
      children: [
        Form(
          key: _formKey2,
          child: Column(
            children: [
              Text("Option"),
              Row(
                children: [
                  Expanded(
                    child: _optionBuilder(
                      title: "Opt 1",
                      value: 1,
                      groupValue: _option2,
                      onChanged: (v) {
                        setState(() {
                          _option2 = v;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: _optionBuilder(
                      title: "Opt 2",
                      value: 2,
                      groupValue: _option2,
                      onChanged: (v) {
                        setState(() {
                          _option2 = v;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _lipsum,
                keyboardType: TextInputType.name,
                validator: _validator,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Lipsum',
                  labelText: kSLipsum.substring(0, 10),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0),
        Row(
          children: [
            Expanded(
              child: _button(
                title: "Sebelumnya",
                onTap: _onPrev,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: _button(
                title: "Selanjutnya",
                onTap: _onNext,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _page3() {
    return Column(
      children: [
        Text("Option"),
        Row(
          children: [
            Expanded(
              child: _optionBuilder(
                title: "Opt 1",
                value: 1,
                groupValue: _option31,
                onChanged: (v) {
                  setState(() {
                    _option31 = v;
                  });
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: _optionBuilder(
                title: "Opt 2",
                value: 2,
                groupValue: _option31,
                onChanged: (v) {
                  setState(() {
                    _option31 = v;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text("Option"),
        Row(
          children: [
            Expanded(
              child: _optionBuilder(
                title: "Opt 1",
                value: 1,
                groupValue: _option32,
                onChanged: (v) {
                  setState(() {
                    _option32 = v;
                  });
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: _optionBuilder(
                title: "Opt 2",
                value: 2,
                groupValue: _option32,
                onChanged: (v) {
                  setState(() {
                    _option32 = v;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 32.0),
        Row(
          children: [
            Expanded(
              child: _button(
                title: "Sebelumnya",
                onTap: _onPrev,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: _button(
                title: "Submit",
                onTap: _onNext,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _optionBuilder({
    @required String title,
    @required dynamic value,
    @required dynamic groupValue,
    @required Function(dynamic d) onChanged,
  }) {
    return ListTile(
      title: Text(title),
      leading: Radio(
        activeColor: hPrimary,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }

  Widget _button({@required String title, Function onTap}) {
    return MaterialButton(
      minWidth: double.infinity,
      child: Text("$title"),
      color: hPrimary,
      textColor: Colors.white,
      onPressed: onTap,
    );
  }
}
