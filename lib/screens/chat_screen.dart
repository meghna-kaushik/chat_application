import 'package:flutter/material.dart';
import 'package:chatapp/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:intl/intl.dart';

var user;
final _store = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String msg;
  final _auth = FirebaseAuth.instance;

  final con = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = _auth.currentUser;
    //print(user);
  }

  // void msgstream() async {
  //   await for (var doc in _store.collection('messages').snapshots()) {
  //     for (var msg in doc.docs) {
  //       print(msg.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: 'logo', child: Image.asset('images/logo.png')),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, '/');
              }),
        ],
        title: Text('️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            stream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: con,
                      onChanged: (value) {
                        msg = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      con.clear();
                      _store.collection("messages").add({
                        'msg': msg,
                        'sender': user.email,
                        'time': DateTime.now()
                      });
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class stream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.collection("messages").orderBy("time").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print("yo");
          return Column(
            children: [
              Text(
                "Yo",
                style: TextStyle(color: Colors.black),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            ],
          );
        } else {
          final messages = snapshot.data?.docs.reversed;
          List<Bubble> show = [];
          if (messages != null) {
            for (var single in messages) {
              final text = single['msg'];
              final sender = single['sender'];
              final ti = single['time'];

              var msgtim = DateFormat.jm().format(ti.toDate());

              bool isme = sender == user.email;
              show.add(Bubble(text, sender, isme, msgtim));
            }
          }
          return Expanded(
              child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: show));
        }
        return Text("hey");
      },
    );
  }
}

class Bubble extends StatelessWidget {
  Bubble(this.msg, this.sender, this.isme, this.tim);
  final String sender, msg, tim;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            elevation: 5,
            color: isme ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                msg,
                style: TextStyle(color: isme ? Colors.white : Colors.black),
              ),
            ),
          ),
          Text(tim, style: TextStyle(color: Colors.black54, fontSize: 9))
        ],
      ),
    );
  }
}
