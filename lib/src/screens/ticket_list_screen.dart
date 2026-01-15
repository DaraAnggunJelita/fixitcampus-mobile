import 'package:fixitcampus_mobile/src/screens/create_ticket_screen.dart';
import 'package:flutter/material.dart';
import '../services/ticket_service.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  late Future<List<dynamic>> _tickets;

  @override
  void initState() {
    super.initState();
    _tickets = TicketService.getTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tiket'),
        backgroundColor: const Color(0xFF795548),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _tickets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final tickets = snapshot.data!;

          if (tickets.isEmpty) {
            return const Center(child: Text('Belum ada tiket'));
          }

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final t = tickets[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(t['title']),
                  subtitle: Text(t['description']),
                  trailing: Chip(
                    label: Text(t['status']),
                    backgroundColor: t['status'] == 'open'
                        ? Colors.orange.shade100
                        : Colors.green.shade100,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF795548),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTicketScreen()),
          ).then((_) {
            setState(() {
              _tickets = TicketService.getTickets();
            });
          });
        },
      ),
    );
  }
}
