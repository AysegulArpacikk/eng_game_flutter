import 'package:eng_game_flutter/category/bloc/category_bloc.dart';
import 'package:eng_game_flutter/common/navigations.dart';
import 'package:eng_game_flutter/common/widget/custom_routing.dart';
import 'package:eng_game_flutter/login/bloc/login_bloc.dart';
import 'package:eng_game_flutter/login/bloc/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  _LoginOrRegisterPageState createState() => new _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  late CategoryPageBloc _categoryPageBloc;

  @override
  void initState() {
    super.initState();
    _categoryPageBloc = BlocProvider.of<CategoryPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
        builder: (context, state) {
          if(state is LoginOrRegisterInitialState) {
            return Material(child: _body());
          } else {
            return const Text("Sayfa bulunamadı");
          }
        }
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
          child: Column(
              children: <Widget>[
                _avatar(),
                _buttons()
              ]
          )
      ),
    );
  }

  Widget _avatar() {
    return Stack(
      children: [
        Positioned(
          child: ClipPath(
            clipper: CustomClipPath(),
            child: Container(
                color: const Color.fromRGBO(182, 156, 236, 1.0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4
            ),
          ),
        ),
        const Positioned(
          left: 140,
          top: 80,
          height: 120,
          width: 120,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/panda.png"),
            minRadius: 50,
            maxRadius: 60,
          ),
        ),
      ],
    );
  }

  Widget _buttons() {
      return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 50, right:50),
                child: _userNameAndPassword()
                // const TextField(
                //   maxLength: 20,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Kullanıcı adı girin',
                //   ),
                // ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(CustomRouting(page: categoriesPage(_categoryPageBloc)).createRoute());
                },
                child: const Text('Giriş Yap'),
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.deepPurpleAccent,
                    fixedSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
            _orText(),
            ElevatedButton(
                onPressed: () {},
                child: const Text('Yeni Üyelik'),
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.deepPurpleAccent,
                    fixedSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))
            ),
          ]));
  }

  Widget _userNameAndPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Kullanıcı adı',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Şifre',
            ),
          ),
        ),
      ],
    );
  }

  Widget _orText() {
    return Row(
        children: <Widget>[
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: const Divider(
                  color: Colors.black,
                  height: 36,
                  indent: 55,
                )),
          ),
          const Text(
              " ya da ",
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(118, 130, 132, 1.0),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal
              )
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: const Divider(
                  color: Colors.black,
                  height: 36,
                  endIndent: 55,
                )),
          ),
        ]
    );
  }

}

class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/4, size.height
        - 40, size.width/2, size.height-20);
    path.quadraticBezierTo(3/4*size.width, size.height,
        size.width, size.height-30);
    path.lineTo(size.width, 0);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}