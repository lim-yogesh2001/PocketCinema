import "package:flutter/material.dart";

class CustomAlertBox {
  normalAlertBox(BuildContext context, String message) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Error!",
          style: TextStyle(
              color: Colors.red, fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        content: Text(message, style: const TextStyle(
          color: Colors.black87
        ),),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Okay"))
        ],
      ),
    );
  }

  regularAlertBox(BuildContext context, String title, String message) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.red, fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        content: Text(message, style: const TextStyle(
          color: Colors.black87
        ),),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Okay"))
        ],
      ),
    );
  }

   customLoadingDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              width: 10,
            ),
            Text("Loading", style: TextStyle(
              color: Colors.black
            ),),
          ],
        ),
      ),
    );
  }
}
