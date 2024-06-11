import 'package:flutter/material.dart';
import 'package:petsgo/service/ConsultaService.dart';
import 'package:petsgo/model/Consulta.dart';


class TelaConsulta extends StatefulWidget {
  @override
  _TelaConsultaState createState() => _TelaConsultaState();
}

class _TelaConsultaState extends State<TelaConsulta> {
  late Future<List<Consulta>> _consultas;
  final Consultaservice _consultaservice = Consultaservice();

  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();


  Consulta? _consultaAtual;

  @override
  void initState() {
    super.initState();
    _atualizarConsulta();
  }

  void _atualizarConsulta() {
    setState(() {
      _consultas = _consultaservice.buscarConsultas();
    });
  }

  void _mostrarFormulario({Consulta? consulta}) {
    if (consulta != null) {
      _consultaAtual = consulta;
      _dataController.text = consulta.data;
      _horaController.text = consulta.hora;
      _descricaoController.text = consulta.descricao;
    } else {
      _consultaAtual = null;
      _dataController.clear();
      _descricaoController.clear();
      _horaController.clear();
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
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data'),
            ),
            TextField(
              controller: _horaController,
              decoration: InputDecoration(labelText: 'Hora'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descricao'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_consultaAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final data = _dataController.text;
    final hora = _horaController.text;
    final descricao = _descricaoController.text;

    if (_consultaAtual == null) {
      final novoConsultas = Consulta(data: data,hora: hora,descricao: descricao);
      await _consultaservice.criarConsulta(novoConsultas);
    }
    else {
      final ConsultasAtualizado = Consulta(
        id: _consultaAtual!.id,
        data: data,
        hora: hora,
        descricao: descricao
      );
      await _consultaservice.atualizarConsulta(ConsultasAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarConsulta();
  }

  void _deletarConsulta(int id) async {
    try {
      await _consultaservice.deletarConsulta(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Consultas deletado com sucesso!')));
      _atualizarConsulta();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Consultas: $error')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultas'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => (),
          ),
        ],
      ),
      body: FutureBuilder<List<Consulta>>(
        future: _consultas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final consulta = snapshot.data![index];
                return ListTile(
                  title: Text(consulta.data),
                  subtitle: Text(consulta.hora),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => (),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => (),
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
