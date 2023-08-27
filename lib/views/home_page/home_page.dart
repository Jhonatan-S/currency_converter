import 'dart:async';
import 'dart:developer';

import 'package:currency_converter/widgets/loadng_flutter_progress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/input_currency.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController brlController = TextEditingController();

  final TextEditingController usdController = TextEditingController();

  final TextEditingController eurController = TextEditingController();

  final TextEditingController gbpController = TextEditingController();

  final TextEditingController cadController = TextEditingController();

  final TextEditingController jpyController = TextEditingController();

  final String url =
      'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_MuxwX01FwFpnikICTAttU5L6HmpXIsyZXSKfPLcF&currencies=BRL%2CEUR%2CUSD%2CCAD%2CGBP%2CJPY&base_currency=BRL';

  Future<Map> _getData() async {
    http.Response response = await http.get(Uri.parse(url));

    return json.decode(response.body);
  }

  late double real;
  late double dolar;
  late double euro;
  late double pound;
  late double canadian;
  late double yen;
  bool startHomePage = false;

  void _realChanged(String text) {
    double input = double.parse(text);
    usdController.text = (input * dolar).toStringAsFixed(2);
    eurController.text = (input * euro).toStringAsFixed(2);
    gbpController.text = (input * pound).toStringAsFixed(2);
    cadController.text = (input * canadian).toStringAsFixed(2);
    jpyController.text = (input * yen).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double input = double.parse(text);
    brlController.text = (input / dolar).toStringAsFixed(2);
    eurController.text = (input / dolar * euro).toStringAsFixed(2);
    gbpController.text = (input / dolar * pound).toStringAsFixed(2);
    cadController.text = (input / dolar * canadian).toStringAsFixed(2);
    jpyController.text = (input / dolar * yen).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double input = double.parse(text);

    brlController.text = (input / euro).toStringAsFixed(2);
    usdController.text = (input / euro * dolar).toStringAsFixed(2);
    gbpController.text = (input / euro * pound).toStringAsFixed(2);
    cadController.text = (input / euro * canadian).toStringAsFixed(2);
    jpyController.text = (input / euro * yen).toStringAsFixed(2);
  }

  void _poundChanged(String text) {
    double input = double.parse(text);

    brlController.text = (input / pound).toStringAsFixed(2);
    usdController.text = (input / pound * dolar).toStringAsFixed(2);
    eurController.text = (input / pound * euro).toStringAsFixed(2);
    cadController.text = (input / pound * canadian).toStringAsFixed(2);
    jpyController.text = (input / pound * yen).toStringAsFixed(2);
  }

  void _canadianChanged(String text) {
    double input = double.parse(text);

    brlController.text = (input / canadian).toStringAsFixed(2);
    usdController.text = (input / canadian * dolar).toStringAsFixed(2);
    eurController.text = (input / canadian * euro).toStringAsFixed(2);
    gbpController.text = (input / canadian * pound).toStringAsFixed(2);
    jpyController.text = (input / canadian * yen).toStringAsFixed(2);
  }

  void _yenChanged(String text) {
    double input = double.parse(text);

    brlController.text = (input / yen).toStringAsFixed(2);
    usdController.text = (input / yen * dolar).toStringAsFixed(2);
    eurController.text = (input / yen * euro).toStringAsFixed(2);
    gbpController.text = (input / yen * pound).toStringAsFixed(2);
    cadController.text = (input / yen * canadian).toStringAsFixed(2);
  }

  void _cleanAll() {
    brlController.clear();
    usdController.clear();
    gbpController.clear();
    eurController.clear();
    cadController.clear();
    jpyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.network(
          'https://app.freecurrencyapi.com/img/logo/freecurrencyapi.png',
          width: 200,
        ),
        centerTitle: true,
        toolbarHeight: 200,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return startHomePage
                  ? const Center( 
                      child: Text('Sucesso'),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Carregando informações...',
                      ),
                    );

            default:
              if (snapShot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Erro ao carregar as informações.\nTente novamente',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Icon(Icons.refresh),
                    )
                  ],
                );
              } else if (!startHomePage) {
                return Center(
                  child: LoadingProgress(
                    onEnd: () {
                      setState(
                        () {
                          startHomePage = true;
                        },
                      );
                    },
                  ),
                );
              } else {
                real = double.parse(snapShot.data!['data']['BRL'].toString());
                dolar = double.parse(snapShot.data!['data']['USD'].toString());
                euro = double.parse(snapShot.data!['data']['EUR'].toString());
                pound = double.parse(snapShot.data!['data']['GBP'].toString());
                canadian =
                    double.parse(snapShot.data!['data']['CAD'].toString());
                yen = double.parse(snapShot.data!['data']['JPY'].toString());

                return Container(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputCurrency(
                          prefixText: 'R\$',
                          currency: 'BRL',
                          controller: brlController,
                          onChanged: (value) {
                            final newValue = value.replaceAll(',', '.');

                            if (RegExp(r'[.,]').allMatches(newValue).length >
                                1) {
                              final correctedValue =
                                  newValue.substring(0, newValue.length - 1);
                              brlController.value = TextEditingValue(
                                text: correctedValue,
                                selection: TextSelection.collapsed(
                                  offset: correctedValue.length,
                                ),
                              );
                            } else {
                              brlController.value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                            if (value.isEmpty) {
                              _cleanAll();
                            }
                            _realChanged(value);
                          },
                        ),
                        InputCurrency(
                          currency: 'USD',
                          prefixText: '\$',
                          controller: usdController,
                          onChanged: (value) {
                            final newValue = value.replaceAll(',', '.');

                            if (RegExp(r'[.,]').allMatches(newValue).length >
                                1) {
                              final correctedValue =
                                  newValue.substring(0, newValue.length - 1);
                              usdController.value = TextEditingValue(
                                text: correctedValue,
                                selection: TextSelection.collapsed(
                                  offset: correctedValue.length,
                                ),
                              );
                            } else {
                              usdController.value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                            if (value.isEmpty) {
                              _cleanAll();
                            }
                            _dolarChanged(value);
                          },
                        ),
                        InputCurrency(
                          controller: eurController,
                          prefixText: '€',
                          currency: 'EUR',
                          onChanged: (value) {
                            final newValue = value.replaceAll(',', '.');

                            if (RegExp(r'[.,]').allMatches(newValue).length >
                                1) {
                              final correctedValue =
                                  newValue.substring(0, newValue.length - 1);
                              usdController.value = TextEditingValue(
                                text: correctedValue,
                                selection: TextSelection.collapsed(
                                  offset: correctedValue.length,
                                ),
                              );
                            } else {
                              usdController.value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                            if (value.isEmpty) {
                              _cleanAll();
                            }
                            _euroChanged(value);
                          },
                        ),
                        InputCurrency(
                          controller: gbpController,
                          prefixText: '£',
                          currency: 'GBP',
                          onChanged: (value) {
                            final newValue = value.replaceAll(',', '.');

                            if (RegExp(r'[.,]').allMatches(newValue).length >
                                1) {
                              final correctedValue =
                                  newValue.substring(0, newValue.length - 1);
                              usdController.value = TextEditingValue(
                                text: correctedValue,
                                selection: TextSelection.collapsed(
                                  offset: correctedValue.length,
                                ),
                              );
                            } else {
                              usdController.value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                            if (value.isEmpty) {
                              _cleanAll();
                            }
                            _poundChanged(value);
                          },
                        ),
                        InputCurrency(
                          controller: cadController,
                          prefixText: '\$',
                          currency: 'CAD',
                          onChanged: (value) {
                            final newValue = value.replaceAll(',', '.');

                            if (RegExp(r'[.,]').allMatches(newValue).length >
                                1) {
                              final correctedValue =
                                  newValue.substring(0, newValue.length - 1);
                              usdController.value = TextEditingValue(
                                text: correctedValue,
                                selection: TextSelection.collapsed(
                                  offset: correctedValue.length,
                                ),
                              );
                            } else {
                              usdController.value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                            if (value.isEmpty) {
                              _cleanAll();
                            }
                            _canadianChanged(value);
                          },
                        ),
                        InputCurrency(
                          controller: jpyController,
                          prefixText: '¥',
                          currency: 'JPY',
                          onChanged: (value) {
                            final newValue = value.replaceAll(',', '.');

                            if (RegExp(r'[.,]').allMatches(newValue).length >
                                1) {
                              final correctedValue =
                                  newValue.substring(0, newValue.length - 1);
                              usdController.value = TextEditingValue(
                                text: correctedValue,
                                selection: TextSelection.collapsed(
                                  offset: correctedValue.length,
                                ),
                              );
                            } else {
                              usdController.value = TextEditingValue(
                                text: newValue,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                            if (value.isEmpty) {
                              _cleanAll();
                            }
                            _yenChanged(value);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
