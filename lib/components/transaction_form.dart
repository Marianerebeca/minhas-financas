import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
   final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    // Atributo widget - Aponta para uma instancia da classe StatefulWidget que tem o atributo onSubmit.
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                // Pega os dados que o usuario digitou e coloca na variavel titleController.
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                // Pega os dados que o usuario digitou e coloca na variavel valueController.
                controller: _valueController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null ? 'Nenhuma Data Selecionada'
                        : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                        ),
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: _showDatePicker,
                    child: const Text('Selecionar Data')),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 1, 100, 90)),
                onPressed: _submitForm,
                child: const Text('Nova Transação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
