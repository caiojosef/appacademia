import 'package:flutter/material.dart';

// Classe principal para agendar aulas
class AgendarAulasPage extends StatefulWidget {
  const AgendarAulasPage({Key? key}) : super(key: key);

  @override
  _AgendarAulasPageState createState() => _AgendarAulasPageState();
}

class _AgendarAulasPageState extends State<AgendarAulasPage> {
  bool isFitDanceSelected = false;
  String? selectedDate;
  String? selectedTime;

  void _selectFitDance() {
    setState(() {
      isFitDanceSelected = true;
    });
  }

  void _goBackToMenu() {
    setState(() {
      isFitDanceSelected = false;
    });
  }

  void _scheduleClass() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Agendamento feito com sucesso!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          isFitDanceSelected ? 'Agendar FitDance' : 'Agendamentos de aulas',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: isFitDanceSelected ? _buildFitDanceSchedule() : _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMenuItem(
                  context,
                  'FitDance',
                  _selectFitDance,
                ),
                const SizedBox(height: 10),
                _buildMenuItem(
                  context,
                  'Funcional',
                  () {
                    _showComingSoonDialog(context);
                  },
                ),
                const SizedBox(height: 10),
                _buildMenuItem(
                  context,
                  'JumP',
                  () {
                    _showComingSoonDialog(context);
                  },
                ),
                const SizedBox(height: 10),
                _buildMenuItem(
                  context,
                  'Zumba',
                  () {
                    _showComingSoonDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.black,
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/logo_academia.png',
          height: 100,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFitDanceSchedule() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Agendamento de FitDance',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Datas disponíveis de aulas:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2101),
              );
              if (date != null) {
                setState(() {
                  selectedDate = "${date.day}/${date.month}/${date.year}";
                });
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(selectedDate ?? 'Selecione uma data'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Horários disponíveis de aulas:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedTime,
            items: List.generate(
              19,
              (index) {
                final time = '${index + 5}:00${index + 5 < 12 ? 'am' : 'pm'}';
                return DropdownMenuItem(
                  value: time,
                  child: Text(time),
                );
              },
            ),
            onChanged: (value) {
              setState(() {
                selectedTime = value;
              });
            },
            hint: const Text('Selecione um horário'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: selectedDate != null && selectedTime != null ? _scheduleClass : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text('Agendar'),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: _goBackToMenu,
            backgroundColor: Colors.black,
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Em breve'),
          content: const Text('Esta funcionalidade estará disponível em breve.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
