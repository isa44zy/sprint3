import 'package:flutter/material.dart';
import 'package:petsgo/service/ProprietarioService.dart';
import 'package:petsgo/model/Proprietario.dart';


class TelaProprietario extends StatefulWidget {
  @override
  _TelaProprietarioState createState() => _TelaProprietarioState();
}

class _TelaProprietarioState extends State<TelaProprietario> {
  late Future<List<Proprietario>> _proprietarios;
  final Proprietarioservice _proprietarioservice = Proprietarioservice();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _numeroRuaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _nomeRuaController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _telefoneFixoController = TextEditingController();
  final TextEditingController _telefoneCelularController = TextEditingController();

  Proprietario? _proprietarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarProprietario();
  }

  void _atualizarProprietario() {
    setState(() {
      _proprietarios = _proprietarioservice.buscarProprietarios();
    });
  }

  void _mostrarFormulario({Proprietario? proprietario}) {
    if (proprietario != null) {
      _proprietarioAtual = proprietario;
      _nomeController.text = proprietario.nome;
      _cidadeController.text = proprietario.cidade;
      _numeroRuaController.text = proprietario.numeroRua;
      _bairroController.text = proprietario.bairro;
      _nomeRuaController.text = proprietario.nomeRua;
      _cpfController.text = proprietario.cpf;
      _rgController.text = proprietario.rg;
      _telefoneFixoController.text = proprietario.telefoneFixo;
      _telefoneCelularController.text = proprietario.telefoneCelular;
    } else {
      _proprietarioAtual = null;
      _nomeController.clear();
      _cidadeController.clear();
      _numeroRuaController.clear();
      _bairroController.clear();
      _nomeRuaController.clear();
      _cpfController.clear();
      _rgController.clear();
      _telefoneFixoController.clear();
      _telefoneCelularController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _numeroRuaController,
              decoration: InputDecoration(labelText: 'Numero da rua'),
            ),
            TextField(
              controller: _bairroController,
              decoration: InputDecoration(labelText: 'Bairro'),
            ),
            TextField(
              controller: _nomeRuaController,
              decoration: InputDecoration(labelText: 'Nome da rua'),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _rgController,
              decoration: InputDecoration(labelText: 'RG'),
            ),
            TextField(
              controller: _telefoneCelularController,
              decoration: InputDecoration(labelText: 'Telefone celular'),
            ),
            TextField(
              controller: _telefoneFixoController,
              decoration: InputDecoration(labelText: 'Telefone fixo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_proprietarioAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final cidade = _cidadeController.text;
    final nomeRua = _nomeRuaController.text;
    final bairro = _bairroController.text;
    final numeroRua = _numeroRuaController.text;
    final cpf = _cpfController.text;
    final rg = _rgController.text;
    final telefoneFixo = _telefoneFixoController.text;
    final telefoneCelular = _telefoneCelularController.text;

    if (_proprietarioAtual == null) {
      final novoProprietarios = Proprietario(
          nome: nome,
          cidade: cidade,
          numeroRua: numeroRua,
          bairro: bairro,
          nomeRua: nomeRua,
          cpf: cpf,
          rg: rg,
          telefoneFixo: telefoneFixo,
          telefoneCelular: telefoneCelular,
      );
      await _proprietarioservice.criarProprietario(novoProprietarios);
    }
    else {
      final ProprietariosAtualizado = Proprietario(
        id: _proprietarioAtual!.id,
          nome: nome,
          cidade: cidade,
          numeroRua: numeroRua,
          bairro: bairro,
          nomeRua: nomeRua,
          cpf: cpf,
          rg: rg,
          telefoneFixo: telefoneFixo,
          telefoneCelular: telefoneCelular,
      );
      await _proprietarioservice.atualizarProprietario(ProprietariosAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarProprietario();
  }

  void _deletarProprietario(int id) async {
    try {
      await _proprietarioservice.deletarProprietario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proprietarios deletado com sucesso!')));
      _atualizarProprietario();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Proprietarios: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proprietarios'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => (),
          ),
        ],
      ),
      body: FutureBuilder<List<Proprietario>>(
        future: _proprietarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final proprietario = snapshot.data![index];
                return ListTile(
                  title: Text(proprietario.nome),
                  subtitle: Text(proprietario.telefoneCelular),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(proprietario: proprietario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarProprietario(proprietario.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
