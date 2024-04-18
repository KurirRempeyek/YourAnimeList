import 'package:flutter/material.dart';

class Ponyo extends StatelessWidget {
  const Ponyo({super.key});

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
                          'assets/images/ponyo.jpg',
                          height: 300,
                          width: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Gake no Ue no Ponyo',
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
                    'A goldfish sneaks away from home and floats off on the back of a jellyfish. After getting stuck in a glass jar, she drifts to the shore where she is freed by Sousuke, a five-year-old boy who lives with his mother Lisa in a house by the sea while his father Koichi works on a fishing boat. After healing a cut on Sousuke\'s finger by licking it, the goldfish is named Ponyo by her new friend.\n\nUnknown to Sousuke, Ponyo already has a name and a family. Her father Fujimoto, a sorcerer who forsook his humanity to live underwater, searches frantically for his daughter Brunhilde. When found and captured, Ponyo rejects her birth name and declares that she wants to become a human. Using the power received from Sousuke\'s blood, she grows arms and legs and escapes to the surface once more. But the magic released into the ocean causes an imbalance in nature, causing the Moon to start falling out of orbit and the tides to grow dangerously stronger. Reunited with Ponyo, Sousuke must pass an ancient test to restore order in the world and let his companion live on as a human.',
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
