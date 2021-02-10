import 'package:MONITOR/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';

class Login extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/img.jpeg',
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'MR.MONITOR',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'User Id',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Expanded(
                        child: MaterialButton(
                          color: Colors.blue[900],
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(HomeScreen.routeName, arguments: {
                              'uid': '${controller.text}',
                            });
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/img.jpeg',
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/img.jpeg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
