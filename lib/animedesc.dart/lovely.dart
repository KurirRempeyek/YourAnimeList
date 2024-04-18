import 'package:flutter/material.dart';

class LovelyComplex extends StatelessWidget {
  const LovelyComplex({super.key});

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
                          'assets/images/lovelycomplex.jpg',
                          height: 300,
                          width: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Lovely★Complex',
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
                    'Love is unusual for Risa Koizumi and Atsushi Ootani, who are both striving to find their ideal partner in high school—172 cm tall Koizumi is much taller than the average girl, and Ootani is much shorter than the average guy at 156 cm. To add to their plights, their crushes fall in love with each other, leaving Koizumi and Ootani comically flustered and heartbroken. To make matters worse, they\'re even labeled as a comedy duo by their homeroom teacher due to their personalities and the stark difference in their heights, and their classmates even think of their arguments as sketches.\n\nLovely★Complex follows Koizumi and Ootani as they encourage each other in finding love and become close friends. Apart from their ridiculous antics, they soon find out an unexpected similarity in their music and fashion tastes. Maybe they possess a chemistry yet unknown, but could love ever bloom between the mismatched pair?',
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
