import 'package:flutter/material.dart';
import 'package:tec_app/pages/user/userlogin.dart';
import 'package:tec_app/pages/worker/workerlogin.dart';


class Openpage extends StatelessWidget {
  const Openpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/logo.jpg'),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.orangeAccent[400],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>workerlogin() ));
                },
                child: Text("Worker",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.orangeAccent[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Userlogin()));
                },
                child: Text("User",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
