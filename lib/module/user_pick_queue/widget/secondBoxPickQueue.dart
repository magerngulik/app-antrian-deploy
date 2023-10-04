import 'package:flutter/material.dart';

class SecondBoxPickQueue extends StatelessWidget {
  final int numberWaiting;
  final String titleFunction1;
  final Function() ontapFunction1;
  final String titleFunction2;
  final Function() ontapFunction2;
  final String titleFunction3;
  final Function() ontapFunction3;
  final String titleFunction4;
  final Function() ontapFunction4;

  const SecondBoxPickQueue({
    super.key,
    required this.numberWaiting,
    required this.titleFunction1,
    required this.ontapFunction1,
    required this.titleFunction2,
    required this.ontapFunction2,
    required this.titleFunction3,
    required this.ontapFunction3,
    required this.titleFunction4,
    required this.ontapFunction4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Waiting List",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey[900]!,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "$numberWaiting",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 120.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: MediaQuery.of(context).size.height / 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => ontapFunction1(),
                            child: Text(
                              titleFunction1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: MediaQuery.of(context).size.height / 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => ontapFunction2(),
                            child: Text(
                              titleFunction2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: MediaQuery.of(context).size.height / 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => ontapFunction3(),
                            child: Text(
                              titleFunction3,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: MediaQuery.of(context).size.height / 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => ontapFunction4(),
                            child: Text(
                              titleFunction4,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
