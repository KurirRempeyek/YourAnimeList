import 'package:flutter/material.dart';

class Aikatsu extends StatelessWidget {
  const Aikatsu({super.key});

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
                          'assets/images/aikatsu.jpg',
                          height: 300,
                          width: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Aikatsu!',
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
                    'An idol\'s brilliance illuminates the dreams of humanity. Starlight Academy, a holy ground for celebrities in training, seeks to realize this belief. Behind its rigorous entrance requirements lie not only the top young stars in the entertainment business, but some of the best memories these students will ever have. \n\nOr so Aoi Kiriya believes. Alongside her best friend Ichigo, Aoi decides to apply for the prestigious private school in hopes of living up to the praise of the biggest idol in the world: Mizuki Kanzaki. As they journey through the numerous laughs, friendships, and heartbreaks that await them, can the two girls light up the lives of others as Mizuki has done for them? \n\nWhether it be chopping down Christmas trees, traversing obstacle courses, or even rock climbing, there\'s always a playful new adventure to be found in the world of Aikatsu!',
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
