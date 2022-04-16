import 'package:flutter/material.dart';

void main() {
  runApp(
    //monta o ambiente (elementos gráficos)
    MaterialApp(
      home: Home(), // rota de entrada da aplicação
      debugShowCheckedModeBanner: false, //remove o banner de Debug
    ),
  );
}

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  // Criação de um controle para o nosso formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //variavel para armazenar o resultado
  String _resultado = '';

  // view
  double iconSize = 0;
  bool IconControl = false;
  //definição dos métodos

  // método para calcular o combústivel ideal
  void _calculaCombustivelIdeal() {
    setState(() {
      //criando e convertendo os valores digitados
      double varAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));
      double varGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));

      //m mdedindo proporção dos combustiveis
      double proporcao = varAlcool / varGasolina;

      //atualizar a variavel de resposta
      _resultado =
          (proporcao < 0.7 ? 'abasteça com Álcool' : 'Abasteça com Gasolina');

      if (proporcao < 0.7) {
        IconControl = true;
      } else {
        IconControl = false;
      }

      alcoolController.clear();
      gasolinaController.clear();
      iconSize = 80;
    });
  }

  void _reset() {
    //limpando controllers
    alcoolController.clear();
    gasolinaController.clear();

    setState(() {
      // atualizar os estados das variáveis
      iconSize = 0;
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Álcool ou Gasolina',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                //chamar um método que limpa as entradas e as variáveis
                _reset();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 80,
                color: Colors.lightBlue[900],
              ),

              //montando os campos de edição
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,

                // validação da entrada
                validator: (value) =>
                    value!.isEmpty ? 'informe o valor do álcool' : null,
                decoration: InputDecoration(
                  labelText: 'Valor do Álcool',
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),

              // novo Input para gasolina
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'informe o valor da gasolina' : null,
                decoration: InputDecoration(
                  labelText: 'Valor da Gasolina',
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),

              //criar o botão para calcular
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Container(
                  height: 50,
                  child: RawMaterialButton(
                    onPressed: () {
                      //verificar dos valores
                      if (_formKey.currentState!.validate())
                        _calculaCombustivelIdeal();
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    fillColor: Colors.lightBlue[900],
                  ),
                ),
              ),

              // Mostrando o resultado
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlue[900],
                ),
              ),
              Icon(
                Icons.local_gas_station,
                size: iconSize,
                color: IconControl ? Colors.red : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
