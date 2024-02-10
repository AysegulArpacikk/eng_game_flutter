import 'package:eng_game_flutter/category/bloc/a1/a1_bloc.dart';
import 'package:eng_game_flutter/category/bloc/a1/a1_event.dart';
import 'package:eng_game_flutter/category/bloc/category_bloc.dart';
import 'package:eng_game_flutter/category/bloc/category_state.dart';
import 'package:eng_game_flutter/common/navigations.dart';
import 'package:eng_game_flutter/common/widget/custom_routing.dart';
import 'package:eng_game_flutter/pairingWords/bloc/pairing_word_page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => new _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool selected = false;
  bool credit = false;

  double selectedWidthActive = 0;
  double selectedHeightActive = 0;

  late PairingWordPageBloc _pairingWordPageBloc;

  @override
  void initState() {
    _pairingWordPageBloc = BlocProvider.of<PairingWordPageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryPageBloc, CategoryPageState>(
        builder: (context, state) {
          if (state is CategoriesFetchedState) {
            return Material(child: Container(
                   child: _body(state)));
          } else {
            return const Text("Sayfa bulunamadı");
          }
        }
    );
  }

  Widget _body(CategoriesFetchedState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Hoşgeldin"),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Center(
          child: Padding(
          padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column (
            children: [
              _categoryList(state.categories)
            ],
          )
      )
    ))));
  }

  Widget _categoryList(List<dynamic> categoryGroup) {
    List<Widget> list = [];

    for (var category in categoryGroup) {
      var cat = categoryItem2(category);
      list.add(cat);
    }

    return GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 60,
        children: list,
    );
  }

  Widget categoryItem2(dynamic category) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double selectedWidthInActive = width * 0.40;
    double selectedHeightInActive = height * 0.40;
    return GestureDetector(
        onTap: () {
          if (category["name"] == "A1") {
            Navigator.of(context).push(CustomRouting(page: pairingWordPage(_pairingWordPageBloc, category["pairWords"], 0)).createRoute());
          } else if (category["name"] == "A2") {
            Navigator.of(context).push(CustomRouting(page: pairingWordPage(_pairingWordPageBloc, category["pairWords"], 1)).createRoute());
          } else if (category["name"] == "B1") {
            Navigator.of(context).push(CustomRouting(page: pairingWordPage(_pairingWordPageBloc, category["pairWords"], 2)).createRoute());
          } else if(category["name"] == "B2") {
            Navigator.of(context).push(CustomRouting(page: pairingWordPage(_pairingWordPageBloc, category["pairWords"], 3)).createRoute());
          } else if(category["name"] == "C1") {
            Navigator.of(context).push(CustomRouting(page: pairingWordPage(_pairingWordPageBloc, category["pairWords"], 4)).createRoute());
          } else {
            Navigator.of(context).push(CustomRouting(page: pairingWordPage(_pairingWordPageBloc, category["pairWords"], 5)).createRoute());
          }
        },
        child: Container(
          width: selected ? selectedWidthActive : selectedWidthInActive,
          height: selected ? selectedHeightActive : selectedHeightInActive,
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffFFD4E2), Color(0xffFFD4E2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
                category["name"],
                style: TextStyle(
                    fontSize: 50,
                    color: category["name"].toString().startsWith('A') ? const Color.fromRGBO(157, 110, 203, 1.0) :
                    category["name"].toString().startsWith('B') ? const Color.fromRGBO(110, 170, 203, 1.0) :
                                                              const Color.fromRGBO(201, 150, 107, 1.0),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold
                )
            ),
          ),
        )
    );
  }
}