import 'package:flutter/material.dart';

class Mahoutsukai extends StatelessWidget {
  const Mahoutsukai({super.key});

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
                          'assets/images/mahoutsukai.jpg',
                          height: 300,
                          width: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Mahoutsukai no Yome',
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
                    'Chise Hatori, a 15-year-old Japanese girl, was sold for five million pounds at an auction to a tall masked gentleman. Abandoned at a young age and ridiculed by her peers for her unconventional behavior, she was ready to give herself to any buyer if it meant having a place to go home to. In chains and on her way to an unknown fate, she hears whispers from robed men along her path, gossiping and complaining that such a buyer got his hands on a rare Sleigh Beggy.\n\nIgnoring the murmurs, the mysterious man leads the girl to a study, where he reveals himself to be Elias Ainsworth—a magus. After a brief confrontation and a bit of teleportation magic, the two open their eyes to Elias\' picturesque cottage in rural England. Greeted by fairies and surrounded by weird and wonderful beings upon her arrival, these events mark the beginning of Chise\'s story as the apprentice and supposed bride of the ancient magus.',
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
