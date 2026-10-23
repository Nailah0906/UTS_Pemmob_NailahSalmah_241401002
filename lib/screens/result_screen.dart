import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String playerName;
  final int finalScore;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.playerName,
    required this.finalScore,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // bg kotak
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgkotak2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // gradien bg
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 450,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 147, 205, 255).withValues(alpha: 0.9),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center( 
              child: ConstrainedBox( 
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hasil Kuis',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'ComicRelief',
                          shadows: [
                            Shadow(offset: Offset(3, 3), blurRadius: 7, color: Colors.black45),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // skor
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/hachiyey.png',
                              width: 190,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Selamat, $playerName!! :3',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.abu,
                                fontFamily: 'ComicRelief',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Skor Kamu: $finalScore / ${totalQuestions * 10}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: AppTheme.biruPastel,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ComicRelief',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // restart button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // balik ke homescreen
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.biruPastel,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'MAIN LAGI',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}