import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anime of the Season',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            //wrap container in a row
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/aikatsu');
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    'assets/images/aikatsu.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/hanakokun');
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    'assets/images/hanakokun.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/hataraku');
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    'assets/images/hatarakusaibou.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/lovely');
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    'assets/images/lovelycomplex.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/mahoutsukai');
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    'assets/images/mahoutsukai.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/ponyo');
                },
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    'assets/images/ponyo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
