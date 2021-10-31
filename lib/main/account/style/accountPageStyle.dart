import 'package:flutter/material.dart';

class AccountPageWidget {
  Widget listviewTickets({required List data, required BuildContext context}) {
    return data.isEmpty
        ? emptyState(
            msg: "Non hai nessun biglietto al momento", context: context)
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) => Card(
                  child: Text("Biglietto: ${data[i]["Data1"]}"),
                ));
  }

  Widget listviewTails({required List data, required BuildContext context}) {
    return data.isEmpty
        ? emptyState(
            msg: "Non sei in nessuna coda al momento", context: context)
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) => Card(
                  child: Text("Coda: $i°"),
                ));
  }

  Widget emptyState({required String msg, required BuildContext context}) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: Colors.black26,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
