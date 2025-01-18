import 'dart:math';
import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _tabuleiro = List.filled(9, '');
  String _jogadorAtual = 'X';
  bool _jogandoContraComputador = false;
  final Random _random = Random();
  bool _computadorPensando = false;

  void _reiniciarJogo() {
    setState(() {
      _tabuleiro = List.filled(9, '');
      _jogadorAtual = 'X';
      _computadorPensando = false;
    });
  }

  void _alternarJogador() {
    setState(() {
      _jogadorAtual = _jogadorAtual == 'X' ? 'O' : 'X';
    });
  }

  void _exibirDialogoResultado(String resultado) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            resultado == 'Empate' ? 'O jogo terminou em um empate!' : 'Parabéns! $resultado venceu!',
            style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _reiniciarJogo();
              },
              child: const Text('Jogar Novamente'),
            ),
          ],
        );
      },
    );
  }

  bool _verificarVitoria(String jogador) {
    const combinacoesVencedoras = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combinacao in combinacoesVencedoras) {
      if (_tabuleiro[combinacao[0]] == jogador &&
          _tabuleiro[combinacao[1]] == jogador &&
          _tabuleiro[combinacao[2]] == jogador) {
        return true;
      }
    }
    return false;
  }

  void _verificarFimDeJogo() {
    if (_verificarVitoria('X')) {
      _exibirDialogoResultado('X');
    } else if (_verificarVitoria('O')) {
      _exibirDialogoResultado('O');
    } else if (!_tabuleiro.contains('')) {
      _exibirDialogoResultado('Empate');
    }
  }

  void _jogadaComputador() {
    setState(() => _computadorPensando = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      int melhorMovimento = _encontrarMelhorMovimento();
      setState(() {
        _tabuleiro[melhorMovimento] = 'O';
        _computadorPensando = false;
        _verificarFimDeJogo();
        if (!_verificarVitoria('O')) {
          _alternarJogador();
        }
      });
    });
  }

  int _encontrarMelhorMovimento() {
    for (int i = 0; i < _tabuleiro.length; i++) {
      if (_tabuleiro[i] == '') {
        _tabuleiro[i] = 'O';
        if (_verificarVitoria('O')) {
          _tabuleiro[i] = '';
          return i;
        }
        _tabuleiro[i] = '';
      }
    }

    for (int i = 0; i < _tabuleiro.length; i++) {
      if (_tabuleiro[i] == '') {
        _tabuleiro[i] = 'X';
        if (_verificarVitoria('X')) {
          _tabuleiro[i] = '';
          return i;
        }
        _tabuleiro[i] = '';
      }
    }

    if (_tabuleiro[4] == '') {
      return 4;
    }

    final bordas = [0, 2, 6, 8];
    for (var borda in bordas) {
      if (_tabuleiro[borda] == '') {
        return borda;
      }
    }

    final laterais = [1, 3, 5, 7];
    for (var lateral in laterais) {
      if (_tabuleiro[lateral] == '') {
        return lateral;
      }
    }

    return _random.nextInt(9);
  }

  void _realizarJogada(int index) {
    if (_tabuleiro[index] == '' && !_computadorPensando) {
      setState(() {
        _tabuleiro[index] = _jogadorAtual;
        _verificarFimDeJogo();
        if (!_verificarVitoria(_jogadorAtual)) {
          _alternarJogador();
          if (_jogandoContraComputador && _jogadorAtual == 'O') {
            _jogadaComputador();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double tamanhoTabuleiro = MediaQuery.of(context).size.height * 0.5;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ToggleButtons(
            isSelected: [_jogandoContraComputador, !_jogandoContraComputador],
            onPressed: (index) {
              setState(() {
                _jogandoContraComputador = index == 0;
                _reiniciarJogo();
              });
            },
            borderRadius: BorderRadius.circular(8),
            selectedColor: Colors.black,
            fillColor: Colors.amber.shade700,
            children: const [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Computador')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Humano')),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: SizedBox(
            width: tamanhoTabuleiro,
            height: tamanhoTabuleiro,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _realizarJogada(index),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber.shade200, Colors.amber.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _tabuleiro[index],
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber.shade800,
            ),
            onPressed: _reiniciarJogo,
            child: const Text('Reiniciar Jogo'),
          ),
        ),
      ],
    );
  }
}
