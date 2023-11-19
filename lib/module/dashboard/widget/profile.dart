// ignore_for_file: camel_case_types
import 'package:antrian_app/constants.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  // final String value;
  // final Function(String value) onChanged;
  // final String? label;

  const Profile({
    Key? key,
    // required this.value,
    // required this.onChanged,
    // this.label,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> card1 = [
      {
        'name': ' Telepon',
        'subname': '+6289520177891',
        'color': const Color(0xffFF9500),
        'icon': Icons.phone
      },
      {
        'name': ' Email',
        'subname': 'mtechcloud.com',
        'color': const Color.fromARGB(255, 0, 255, 17),
        'icon': Icons.email
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(124 / 2),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                        spreadRadius: 8)
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 42.0,
                    child: FlutterLogo(size: 40),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'CV ANEKA TECH',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 4.0,
                      bottom: 4.0,
                    ),
                    child: Text(
                      "Jl Perum Serasi Indah Majalaya Karawang",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                        spreadRadius: 8)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Information",
                        style: TextStyle(
                          color: const Color(0xff3C3C43).withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Column(
                        children: card1.map(
                          (e) {
                            return SizedBox(
                              height: 50,
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 38,
                                          width: 38,
                                          padding: const EdgeInsets.all(5.5),
                                          decoration: BoxDecoration(
                                            color: e['color'],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            e['icon'],
                                            size: 24.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          e['name'],
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          e['subname'],
                                          style: TextStyle(
                                            color: const Color(0xff3C3C43)
                                                .withOpacity(0.6),
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
