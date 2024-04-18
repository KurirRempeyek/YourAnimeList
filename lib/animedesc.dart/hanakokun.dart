import 'package:flutter/material.dart';

class HanakoKun extends StatelessWidget {
  const HanakoKun({super.key});

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
                          'assets/images/hanakokun.jpg',
                          height: 300,
                          width: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Jibaku Shounen Hanako-kun',
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
                    'The famous Seven Mysteries that every school seems to have are a staple of Japanese urban legends. One of the most well-known of these tales is that of Hanako-san: the ghost of a young girl who haunts the school\'s bathrooms.\n\nKamome Academy has its own version of Hanako-san\'s legend. Rumors claim that if one successfully manages to summon Hanako-san, she will grant her summoner any wish. Lured by the gossip, many people have tried to call upon her, yet every attempt has failed. However, when Nene Yashiro, a girl hoping for romantic fortune, dares to summon Hanako-san, she discovers that the rumored "girl" is actually a boy!\n\nAfter a series of unfortunate events involving Yashiro\'s romantic desires, she is unwillingly entangled in the world of the supernatural, becoming Hanako-kun\'s assistant. Soon, she finds out about Hanako-kun\'s lesser-known duty: maintaining the fragile balance between mortals and apparitions.',
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
