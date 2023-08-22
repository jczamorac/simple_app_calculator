
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _moeda = '';
  String _tipo = '';
  String _data = '';
  double _spot = 0;
  double _spread = 0;
  double _volume = 0;
  double _taxa = 0;
  double _iof = 0;
  double _contrato = 0;
  double _conversao = 0;
  double _totalSum = 0;
  double _percentageOfVolume = 0;
  double _average = 0;
  double _iofreal = 0;

  final _numberFormat = NumberFormat('#,##0.00','pt_BR');
  final _numberFormatTaxa = NumberFormat('#,##0.0000','pt_BR');
  //final _numberFormat = NumberFormat.compactCurrency(decimalDigits: 2, locale: 'pt_BR');
  //final _numberFormatTaxa = NumberFormat.compactCurrency(decimalDigits: 4, locale: 'pt_BR');
  final _percentageFormat = NumberFormat.percentPattern('pt_BR');

  void _calculateValues() {
    setState(() {
      _taxa = _spot*(1 + _spread/100);
      _conversao = _taxa*_volume;
      _percentageOfVolume = 0.1 * _volume;
      _iofreal = _iof/100*_conversao;
      _totalSum = _conversao  + _iofreal + _contrato;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Cambio'),
      ),
      body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _moeda = value;
                });
              },
              decoration: InputDecoration(labelText: 'Moeda'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _tipo = value;
                });
              },
              decoration: InputDecoration(labelText: 'Tipo'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _spot = double.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'SPOT'),
            ),
            
            TextField(
              onChanged: (value) {
                setState(() {
                  _spread = double.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Spread [\%] (positivo: saida, negativo: entrada)'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _volume = double.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Volume'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _iof = double.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'IOF [\%] (positivo: saida, negativo: entrada)'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _contrato = double.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Contrato [R\$] (positivo: saida, negativo: entrada)'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _data = value;
                });
              },
              decoration: InputDecoration(labelText: 'Data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateValues,
              child: Text('Calculate Values'),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width / 2, // Reduce width by half
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Cotação Indicativa', // Title
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Data: $_data', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Tipo:', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_tipo),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Moeda', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_moeda),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Volume', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_numberFormat.format(_volume)),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Taxa', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_numberFormatTaxa.format(_taxa)),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Conversão', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                          'R\$ ${_numberFormat.format(_conversao)}', // Add "R$" text
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('IOF', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                          'R\$ ${_numberFormat.format(_iofreal)}', // Add "R$" text
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Contrato', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                          'R\$ ${_numberFormat.format(_contrato)}', // Add "R$" text
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Total', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                          'R\$ ${_numberFormat.format(_totalSum)}', // Add "R$" text
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Add spacing
            Text(
              '* Cotação pode sofrer alteração por movimentações do mercado', // Footnote
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
       ),
      ),
    );
  }
}







