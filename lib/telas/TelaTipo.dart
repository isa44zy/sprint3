import 'package:flutter/material.dart';
import 'package:petsgo/service/TipoService.dart';
import 'package:petsgo/model/Tipo.dart';


class TelaTipo extends StatefulWidget {
  @override
  _TelaTipoState createState() => _TelaTipoState();
}

class _TelaTipoState extends State<TelaTipo> {
  late Future<List<Tipo>> _tipos;
  final Tiposervice _tiposervice = Tiposervice();

  final TextEditingController _nomeController = TextEditingController();

  Tipo? _tipoAtual;

  @override
  void initState() {
    super.initState();
    _atualizarTipo();
  }

  void _atualizarTipo() {
    setState(() {
      _tipos = _tiposervice.buscarTipos();
    });
  }

  void _mostrarFormulario({Tipo? tipo}) {
    if (tipo != null) {
      _tipoAtual = tipo;
      _nomeController.text = tipo.nome;
    } else {
      _tipoAtual = null;
      _nomeController.clear();
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_tipoAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;

    if (_tipoAtual == null) {
      final novoTipos = Tipo(nome: nome);
      await _tiposervice.criarTipo(novoTipos);
    }
    else {
      final tiposAtualizado = Tipo(
        id: _tipoAtual!.id,
        nome: nome,
      );
      await _tiposervice.atualizarTipo(tiposAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarTipo();
  }

  void _deletarTipo(int id) async {
    try {
      await _tiposervice.deletarTipo(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tipos deletado com sucesso!')));
      _atualizarTipo();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Tipos: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipos'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Tipo>>(
        future: _tipos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final tipo = snapshot.data![index];
                return ListTile(
                  title: Text(tipo.nome),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(tipo: tipo),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarTipo(tipo.id!),
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
