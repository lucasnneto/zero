import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:zero/heros/SuperHero.dart';
import 'package:zero/heros/Heros.dart';
import '/socket/SocketManager.dart';

class PersonSelect extends StatefulWidget {
  @override
  _PersonSelectState createState() => _PersonSelectState();
}

class _PersonSelectState extends State<PersonSelect> {
  int count = 0;
  bool loading = false;
  String statusServer = "CONECTANDO";

  @override
  void initState() {
    SocketManager().listenConnection((_) {
      setState(() {
        statusServer = 'CONECTADO';
      });
    });
    SocketManager().listenError((_) {
      setState(() {
        statusServer = 'ERRO: $_';
      });
    });

    SocketManager().listen('message', _listen);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[800],
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Seleção de Herói",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Expanded(
                  child: _buildPersons(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: RaisedButton(
                          color: Colors.orange,
                          child: Text(
                            'ENTRAR',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed:
                              statusServer == 'CONECTADO' ? _goGame : null,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (loading)
              InkWell(
                onTap: () {},
                child: Container(
                  color: Colors.white.withOpacity(0.9),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Carregando")
                      ],
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  statusServer,
                  style: TextStyle(fontSize: 9, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPersons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: count == 0
              ? SizedBox.shrink()
              : Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(0),
                      child: Center(
                          child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      )),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: _previous,
                    ),
                  ),
                ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Heros.heros[count].name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  Heros.heros[count].typeString(),
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: SpriteAnimationWidget(
                    animation: Heros.heros[count].sprite!
                        .createAnimation(row: 6, stepTime: 0.17, to: 7),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: count == Heros.heros.length - 1
              ? SizedBox.shrink()
              : Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(0),
                      child: Center(
                          child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onPressed: _next,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  void _next() {
    if (count < Heros.heros.length - 1) {
      setState(() {
        count++;
      });
    }
  }

  void _previous() {
    if (count > 0) {
      setState(() {
        count--;
      });
    }
  }

  void _goGame() {
    if (SocketManager().connected) {
      setState(() {
        loading = true;
      });
      _joinGame();
    } else {
      print('Server não conectado.');
    }
  }

  void _joinGame() {
    final SuperHero selected = Heros.heros[count];
    print(selected);
    SocketManager().send('message', {
      'action': 'CREATE',
      'data': {'robo': selected.heroId, 'hp': selected.hp}
    });
  }

  void _listen(data) {
    if (data is Map && data['action'] == 'YOUR_PLAYER') {
      setState(() {
        loading = false;
      });

      print(data);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Game(
      //       playersOn: data['data']['playersON'],
      //       nick: nick,
      //       playerId: data['data']['id'],
      //       idCharacter: count,
      //       position: Vector2(
      //         double.parse(data['data']['position']['x'].toString()),
      //         double.parse(data['data']['position']['y'].toString()),
      //       ),
      //     ),
      //   ),
      // );

    }
  }
}
