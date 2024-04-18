import 'package:flutter/material.dart';

class HatarakuSaibou extends StatelessWidget {
  const HatarakuSaibou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/hatarakusaibou.jpg',
                          height: 300,
                          width: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Hataraku Saibou',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Inside the human body, roughly 37.2 trillion cells work energetically 24 hours a day and 365 days a year. Fresh out of training, the cheerful and somewhat airheaded Sekkekkyuu AE3803 is ready to take on the ever-so-important task of transporting oxygen. As usual, Hakkekkyuu U-1146 is hard at work patrolling and eliminating foreign bacteria seeking to make the body their new lair. Elsewhere, little platelets are lining up for a new construction project.\n\nDealing with wounds and allergies, getting lost on the way to the lungs, and bickering with similar cell types, the daily lives of cells are always hectic as they work together to keep the body healthy!',
                    textAlign: TextAlign.justify,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
